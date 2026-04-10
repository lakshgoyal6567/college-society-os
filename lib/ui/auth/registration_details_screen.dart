import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../shared/widgets/app_widgets.dart';

class RegistrationDetailsScreen extends ConsumerStatefulWidget {
  const RegistrationDetailsScreen({super.key});

  @override
  ConsumerState<RegistrationDetailsScreen> createState() =>
      _RegistrationDetailsScreenState();
}

class _RegistrationDetailsScreenState
    extends ConsumerState<RegistrationDetailsScreen> {
  final _phoneController = TextEditingController();
  final _collegeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _collegeController.dispose();
    super.dispose();
  }

  void _submitDetails() async {
    if (_phoneController.text.isEmpty || _collegeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = ref.read(authUserProvider);
      if (user == null) return;

      final updatedUser = user.copyWith(
        phone: _phoneController.text.trim(),
        college: _collegeController.text.trim(),
        isProfileComplete: true,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update(updatedUser.toJson());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Complete Profile',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Just a secondary step to get you started with TIT&S OS.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      label: 'College / Institute Name',
                      hint: 'e.g. TIT&S Bhiwani',
                      controller: _collegeController,
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      label: 'Phone Number',
                      hint: 'e.g. +91 9999999999',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      text: 'Save & Get Started',
                      isLoading: _isLoading,
                      onPressed: _submitDetails,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
