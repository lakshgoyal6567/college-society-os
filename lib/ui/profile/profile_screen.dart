import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/society_provider.dart';
import '../../models/society.dart';
import '../../theme/app_theme.dart';
import '../../shared/widgets/app_widgets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authUserProvider);

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not logged in.')));
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leadingWidth: (kIsWeb && MediaQuery.of(context).size.width < 800) ? 60 : null,
            leading: (kIsWeb && MediaQuery.of(context).size.width < 800) ? const SizedBox() : null,
            title: Text(
              'Identity',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
            backgroundColor: AppTheme.surfaceContainerLowest,
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildUserHeader(context, ref, user),
                  const SizedBox(height: 32),
                  const SectionHeader(
                    title: 'Managed Societies',
                    subtitle: 'Societies where you have administrative access',
                  ),
                  _buildManagedSocieties(context, user),
                  const SizedBox(height: 32),
                  const SectionHeader(
                    title: 'Preferences',
                    subtitle: 'Personalize your TIT&S experience',
                  ),
                  _buildSettingsList(context, ref),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context, WidgetRef ref, dynamic user) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppTheme.primary, AppTheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withAlpha(80),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                user.name.substring(0, 1).toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.onSurface,
                  ),
                ),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: user.isGlobalAdmin
                        ? AppTheme.primary.withAlpha(30)
                        : AppTheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    user.isGlobalAdmin ? 'GLOBAL ADMIN' : 'STUDENT',
                    style: TextStyle(
                      color: user.isGlobalAdmin
                          ? AppTheme.primary
                          : AppTheme.onSurfaceVariant,
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showEditProfileDialog(context, ref, user),
            icon: const Icon(Icons.edit_note_rounded, color: AppTheme.primary),
            tooltip: 'Edit Profile',
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, WidgetRef ref, dynamic user) {
    final nameController = TextEditingController(text: user.name);
    final phoneController = TextEditingController(text: user.phone);
    final collegeController = TextEditingController(text: user.college);
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Edit Profile',
                  style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  label: 'Display Name',
                  controller: nameController,
                  validator: (v) => v?.isEmpty == true ? 'Name is required' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Phone Number',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'College / University',
                  controller: collegeController,
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: 'Save Changes',
                  onPressed: () async {
                    if (formKey.currentState?.validate() == true) {
                      await ref.read(authUserProvider.notifier).updateProfile(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            college: collegeController.text.trim(),
                          );
                      if (context.mounted) Navigator.pop(ctx);
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildManagedSocieties(BuildContext context, dynamic user) {
    return Consumer(
      builder: (context, ref, child) {
        final societiesAsync = ref.watch(societyListProvider);

        if (user.societyRoles.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                'You are not an admin of any society.',
                style: TextStyle(
                  color: AppTheme.onSurfaceVariant.withAlpha(150),
                ),
              ),
            ),
          );
        }

        return Column(
          children:
              user.societyRoles.keys.map<Widget>((id) {
                final society = societiesAsync.asData?.value.firstWhere(
                  (s) => s.societyId == id,
                  orElse: () => Society(
                    societyId: id,
                    name: 'Unknown Society',
                    description: '',
                    logoUrl: '',
                    status: 'active',
                    groups: [],
                  ),
                );

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.tertiaryContainer,
                          backgroundImage:
                              society?.logoUrl.isNotEmpty == true
                                  ? NetworkImage(society!.logoUrl)
                                  : null,
                          child:
                              society?.logoUrl.isNotEmpty != true
                                  ? const Icon(
                                    Icons.group_work,
                                    color: AppTheme.onTertiaryContainer,
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                society?.name ?? 'Loading...',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                user.societyRoles[id]!.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.primary.withAlpha(180),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: AppTheme.outlineVariant,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Widget _buildSettingsList(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildSettingsTile(
          context,
          icon: Icons.notifications_none_outlined,
          title: 'Notifications',
          trailing: Switch(
            value: true,
            onChanged: (v) {},
            activeThumbColor: AppTheme.primary,
          ),
        ),
        _buildSettingsTile(
          context,
          icon: Icons.security_outlined,
          title: 'Account Security',
          onTap: () {},
        ),
        _buildSettingsTile(
          context,
          icon: Icons.help_outline_rounded,
          title: 'Help & Support',
          onTap: () {},
        ),
        const SizedBox(height: 24),
        AppButton(
          text: 'Sign Out',
          onPressed: () => _handleLogout(context, ref),
          isSecondary: true,
          expand: true,
          icon: Icons.logout_rounded,
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      leading: Icon(icon, color: AppTheme.onSurfaceVariant),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing:
          trailing ??
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: AppTheme.outlineVariant,
          ),
      onTap: onTap,
    );
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Shall we disconnect your current session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Stay'),
          ),
          AppButton(
            text: 'Sign Out',
            onPressed: () => Navigator.pop(ctx, true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(authUserProvider.notifier).signOut();
    }
  }
}
