import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../providers/registration_provider.dart';
import '../../models/registration.dart';
import '../../models/event.dart';
import '../../providers/event_provider.dart';
import '../../theme/app_theme.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/widgets/skeleton_loader.dart';

class TicketScreen extends ConsumerWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationsAsync = ref.watch(registrationsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text(
              'Passes',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
            backgroundColor: AppTheme.surfaceContainerLowest,
            centerTitle: false,
          ),
          ...registrationsAsync.when(
            data:
                (registrations) =>
                    registrations.isEmpty
                        ? [
                          const SliverFillRemaining(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.confirmation_number_outlined,
                                    size: 80,
                                    color: AppTheme.outlineVariant,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'No passes yet',
                                    style: TextStyle(
                                      color: AppTheme.onSurfaceVariant,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Register for an event to get your gate pass.',
                                    style: TextStyle(
                                      color: AppTheme.outlineVariant,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                        : [
                          SliverPadding(
                            padding: const EdgeInsets.all(24),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final reg = registrations[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: TicketCard(reg: reg),
                                );
                              }, childCount: registrations.length),
                            ),
                          ),
                        ],
            loading:
                () => [
                  SliverPadding(
                    padding: const EdgeInsets.all(24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 24),
                          child: TicketSkeleton(),
                        );
                      }, childCount: 3),
                    ),
                  ),
                ],
            error:
                (err, stack) => [
                  SliverFillRemaining(
                    child: Center(child: Text('Error: $err')),
                  ),
                ],
          ),
        ],
      ),
    );
  }
}

/// A self-contained ticket card that resolves its own event metadata.
/// Uses [ConsumerWidget] so it can watch [eventListProvider] independently,
/// showing a shimmer placeholder while events load.
class TicketCard extends ConsumerWidget {
  final Registration reg;

  const TicketCard({super.key, required this.reg});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventListProvider);
    final Event? event = eventsAsync.asData?.value.cast<Event?>().firstWhere(
      (e) => e?.eventId == reg.eventId,
      orElse: () => null,
    );

    final bool inactive = reg.checkedIn;
    final Color statusColor = inactive
        ? AppTheme.outlineVariant
        : (reg.paymentStatus == 'pending_cash'
              ? AppTheme.tertiaryFixedDim
              : AppTheme.secondary);

    final String statusLabel = inactive
        ? 'ALREADY USED'
        : (reg.paymentStatus == 'pending_cash' ? 'PENDING CASH' : 'VERIFIED');

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Column(
            children: [
              // ── Banner ──────────────────────────────────────────────────────
              if (event?.details.bannerUrl.isNotEmpty ?? false)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: event!.details.bannerUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (ctx, url) => const SkeletonBox(
                      height: 140,
                      borderRadius: 0,
                    ),
                    errorWidget: (ctx, url, err) => Container(
                      height: 140,
                      color: AppTheme.surfaceContainerHighest,
                      child: const Icon(
                        Icons.event,
                        size: 48,
                        color: AppTheme.outlineVariant,
                      ),
                    ),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    // ── Event Title + Society ──────────────────────────────
                    if (event != null) ...[
                      Text(
                        event.title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (event.societyLogo.isNotEmpty)
                            CircleAvatar(
                              radius: 12,
                              backgroundImage: CachedNetworkImageProvider(
                                event.societyLogo,
                              ),
                            )
                          else
                            const CircleAvatar(
                              radius: 12,
                              backgroundColor: AppTheme.primaryContainer,
                              child: Icon(
                                Icons.group_work,
                                size: 14,
                                color: AppTheme.primary,
                              ),
                            ),
                          const SizedBox(width: 8),
                          Text(
                            event.societyName,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // While events still loading: shimmer placeholder
                      const SkeletonBox(width: 200, height: 22, borderRadius: 6),
                      const SizedBox(height: 8),
                      const SkeletonBox(width: 120, height: 16, borderRadius: 4),
                    ],

                    const SizedBox(height: 32),

                    // ── QR Code ────────────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: statusColor.withAlpha(100),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: QrImageView(
                        data: reg.ticketId,
                        version: QrVersions.auto,
                        size: 200,
                        eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: inactive
                              ? AppTheme.outlineVariant
                              : AppTheme.onSurface,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: inactive
                              ? AppTheme.outlineVariant
                              : AppTheme.onSurface,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Status Badge ───────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        statusLabel,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'ID: ${reg.ticketId}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant.withAlpha(150),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Remind Me Button ───────────────────────────────────
                    if (!inactive && reg.paymentStatus == 'verified')
                      AppButton(
                        text: reg.isNotified ? 'REMINDER SET' : 'REMIND ME',
                        isSecondary: true,
                        icon: reg.isNotified
                            ? Icons.notifications_active
                            : Icons.notifications_outlined,
                        onPressed: reg.isNotified
                            ? null
                            : () => _setupReminder(context, ref, event),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── VOID Overlay ─────────────────────────────────────────────────
          if (inactive)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(150),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Transform.rotate(
                    angle: -0.2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.onSurface, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'VOID',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppTheme.onSurface,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _setupReminder(
    BuildContext context,
    WidgetRef ref,
    Event? event,
  ) async {
    await ref
        .read(registrationControllerProvider.notifier)
        .markAsNotified(reg.ticketId);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reminder set for ${event?.title ?? 'the event'}!',
          ),
          backgroundColor: AppTheme.secondary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(24),
        ),
      );
    }
  }
}
