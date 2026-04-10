import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/society_provider.dart';
import '../../theme/app_theme.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/widgets/skeleton_loader.dart';
import 'create_event_screen.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authUserProvider);
    final requestsAsync = ref.watch(societyRequestsProvider);

    if (user == null || !user.isGlobalAdmin) {
      return const Scaffold(
        body: Center(child: Text('Access Denied. Global Admins Only.')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leadingWidth: (kIsWeb && MediaQuery.of(context).size.width < 800) ? 60 : null,
            leading: (kIsWeb && MediaQuery.of(context).size.width < 800) ? const SizedBox() : null,
            title: Text(
              'Government',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
            backgroundColor: AppTheme.surfaceContainerLowest,
            centerTitle: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: 'Society Requests',
                    subtitle: 'Review and authorize society proposals',
                    trailing: AppButton(
                      text: 'Propose',
                      isSecondary: true,
                      expand: false,
                      onPressed: () => _showProposeDialog(context, ref),
                      icon: Icons.add_rounded,
                    ),
                  ),
                  AppButton(
                    text: 'Create Event',
                    icon: Icons.rocket_launch_rounded,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateEventScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          ...requestsAsync.when(
            data:
                (requests) =>
                    requests.isEmpty
                        ? [
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Center(child: Text('No pending requests.')),
                            ),
                          ),
                        ]
                        : [
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final req = requests[index];
                                final hasApproved = req.approvals.contains(
                                  user.uid,
                                );
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _buildRequestCard(
                                    context,
                                    ref,
                                    req,
                                    hasApproved,
                                  ),
                                );
                              }, childCount: requests.length),
                            ),
                          ),
                        ],
            loading:
                () => [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: SkeletonBox(
                            height: 100,
                            width: double.infinity,
                            borderRadius: 24,
                          ),
                        );
                      }, childCount: 4),
                    ),
                  ),
                ],
            error:
                (err, stack) => [
                  SliverToBoxAdapter(
                    child: Center(child: Text('Error: $err')),
                  ),
                ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(
    BuildContext context,
    WidgetRef ref,
    dynamic req,
    bool hasApproved,
  ) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: req.status == 'approved'
                ? AppTheme.secondaryContainer
                : AppTheme.tertiaryContainer,
            child: Icon(
              req.status == 'approved'
                  ? Icons.check_rounded
                  : Icons.group_add_rounded,
              color: req.status == 'approved'
                  ? AppTheme.onSecondaryContainer
                  : AppTheme.onTertiaryContainer,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${req.action.toUpperCase()}',
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  req.societyName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${req.approvals.length} Approval(s)',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (hasApproved)
            const Icon(Icons.check_circle, color: AppTheme.secondary)
          else
            SizedBox(
              width: 100,
              child: AppButton(
                text: 'Approve',
                onPressed:
                    () => ref
                        .read(societyControllerProvider.notifier)
                        .approveRequest(req.requestId),
              ),
            ),
        ],
      ),
    );
  }

  void _showProposeDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Propose New Society'),
            content: AppTextField(
              label: 'Society Name',
              hint: 'e.g. Robotics Club',
              controller: controller,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              AppButton(
                text: 'Submit Request',
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    ref
                        .read(societyControllerProvider.notifier)
                        .proposeSociety(controller.text);
                    Navigator.pop(ctx);
                  }
                },
              ),
            ],
          ),
    );
  }
}
