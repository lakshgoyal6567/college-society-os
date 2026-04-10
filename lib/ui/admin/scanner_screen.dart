import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../providers/registration_provider.dart';
import '../../theme/app_theme.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/widgets/skeleton_loader.dart';
import '../../shared/analytics/app_analytics.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController();
  final TextEditingController _manualController = TextEditingController();

  void _onScan(String? ticketId) async {
    if (ticketId == null || ticketId.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(
        child: SkeletonBox(height: 60, width: 60, borderRadius: 12),
      ),
    );

    final reg = await ref
        .read(registrationControllerProvider.notifier)
        .findTicketOnline(ticketId);

    if (mounted) Navigator.pop(context);

    if (reg == null) {
      if (mounted) _showStatus('Invalid Ticket', isError: true);
      return;
    }

    if (reg.paymentStatus == 'pending_cash') {
      if (mounted) _showCashVerification(ticketId);
    } else if (reg.checkedIn) {
      if (mounted) _showStatus('Ticket Already Used', isError: true);
    } else if (reg.paymentStatus == 'verified' || reg.paymentStatus == 'free') {
      await ref
          .read(registrationControllerProvider.notifier)
          .checkIn(ticketId);
      await AppAnalytics.logCheckIn(reg.eventId, ticketId);
      if (!mounted) return;
      _showStatus('Access Granted!', isError: false);
    }
  }

  void _showStatus(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: isError ? AppTheme.primary : AppTheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(24),
      ),
    );
  }

  void _showCashVerification(String ticketId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Verify Cash Payment'),
        content: Text('Confirm receipt of cash for Ticket: $ticketId?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          AppButton(
            text: 'Confirm Receipt',
            expand: false,
            onPressed: () async {
              await ref
                  .read(registrationControllerProvider.notifier)
                  .verifyCashPayment(ticketId);
              if (!context.mounted) return;
              Navigator.pop(ctx);
              // ignore: use_build_context_synchronously
              _showStatus('Payment Verified!', isError: false);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _manualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use a plain Scaffold + Column instead of CustomScrollView + SliverFillRemaining
    // because SliverFillRemaining(hasScrollBody: false) cannot compute intrinsic
    // dimensions when Expanded children are present — causing a layout crash.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Security',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: AppTheme.surfaceContainerLowest,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SectionHeader(
              title: 'Ticket Scanner',
              subtitle: 'Position the gate pass QR within the frame',
            ),
            // Scanner takes all available flex — avoids Expanded-inside-sliver issue
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: AppTheme.outlineVariant, width: 1),
                ),
                clipBehavior: Clip.antiAlias,
                child: MobileScanner(
                  controller: _scannerController,
                  onDetect: (capture) {
                    final barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty) {
                      _onScan(barcodes.first.rawValue);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            GlassCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    label: 'Manual Entry',
                    hint: 'Enter Ticket ID',
                    controller: _manualController,
                    prefixIcon: Icons.confirmation_number_outlined,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Verify Manual ID',
                    onPressed: () => _onScan(_manualController.text),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
