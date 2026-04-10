import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/society_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/society.dart';
import '../../models/app_user.dart';
import '../../theme/app_theme.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/widgets/skeleton_loader.dart';
import '../../shared/utils/rbac.dart';

class SocietiesScreen extends ConsumerWidget {
  const SocietiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final societiesAsync = ref.watch(societyListProvider);
    final user = ref.watch(authUserProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text(
              'Societies',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
            backgroundColor: AppTheme.surfaceContainerLowest,
            centerTitle: false,
          ),

          ...societiesAsync.when(
            data: (societies) => societies.isEmpty
                ? [
                    const SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.group_work_outlined,
                              size: 80,
                              color: AppTheme.outlineVariant,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No societies yet',
                              style: TextStyle(
                                color: AppTheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'An admin can propose new societies.',
                              style: TextStyle(color: AppTheme.outlineVariant),
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
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) {
                            final society = societies[i];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _SocietyCard(
                                society: society,
                                user: user,
                              ),
                            );
                          },
                          childCount: societies.length,
                        ),
                      ),
                    ),
                  ],
            loading: () => [
              SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: SkeletonBox(height: 100, borderRadius: 24),
                    ),
                    childCount: 4,
                  ),
                ),
              ),
            ],
            error: (e, stack) => [
              SliverFillRemaining(
                child: Center(child: Text('Error: $e')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocietyCard extends StatelessWidget {
  final Society society;
  final AppUser? user;

  const _SocietyCard({required this.society, required this.user});

  @override
  Widget build(BuildContext context) {
    final myRole = user?.societyRoles[society.societyId];

    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Society logo / avatar
              if (society.logoUrl.isNotEmpty)
                CircleAvatar(
                  radius: 28,
                  backgroundImage:
                      CachedNetworkImageProvider(society.logoUrl),
                )
              else
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppTheme.primaryContainer,
                  child: Text(
                    society.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      society.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    if (society.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        society.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (myRole != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryContainer,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          myRole.toUpperCase(),
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Navigate to detail
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppTheme.outlineVariant,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          SocietyDetailScreen(society: society, user: user),
                    ),
                  );
                },
              ),
            ],
          ),

          // Groups chips
          if (society.groups.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(color: AppTheme.outlineVariant, height: 1),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: society.groups.map((g) {
                return Chip(
                  label: Text(g),
                  backgroundColor: AppTheme.surfaceContainerHighest,
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.onSurfaceVariant,
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Society Detail Screen ────────────────────────────────────────────────────

class SocietyDetailScreen extends ConsumerStatefulWidget {
  final Society society;
  final AppUser? user;

  const SocietyDetailScreen({super.key, required this.society, this.user});

  @override
  ConsumerState<SocietyDetailScreen> createState() =>
      _SocietyDetailScreenState();
}

class _SocietyDetailScreenState extends ConsumerState<SocietyDetailScreen> {
  List<AppUser> _members = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    final members = await ref
        .read(societyControllerProvider.notifier)
        .getSocietyMembers(widget.society.societyId);
    if (mounted) setState(() { _members = members; _loading = false; });
  }

  Future<void> _assignRole(String uid, String role) async {
    try {
      await ref.read(societyControllerProvider.notifier).assignRole(
        societyId: widget.society.societyId,
        uid: uid,
        role: role,
      );
      await _loadMembers();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Role updated to $role'),
            backgroundColor: AppTheme.secondary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(24),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _removeMember(String uid) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Member'),
        content: const Text('Remove this member from the society?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await ref.read(societyControllerProvider.notifier).removeMember(
      societyId: widget.society.societyId,
      uid: uid,
    );
    await _loadMembers();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authUserProvider);
    final canManage = user.isGlobalAdmin ||
        user?.societyRoles[widget.society.societyId] == 'president';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.society.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: AppTheme.surfaceContainerLowest,
        centerTitle: false,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const SectionHeader(
                  title: 'Members',
                  subtitle: 'All roles within this society',
                ),
                if (_members.isEmpty)
                  const Text(
                    'No members yet.',
                    style: TextStyle(color: AppTheme.outlineVariant),
                  ),
                ..._members.map((m) {
                  final role = m.societyRoles[widget.society.societyId] ?? 'member';
                  return GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.primaryContainer,
                          child: Text(
                            m.name.isEmpty ? '?' : m.name[0].toUpperCase(),
                            style: const TextStyle(color: AppTheme.primary),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m.name.isEmpty ? m.email : m.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                role.toUpperCase(),
                                style: const TextStyle(
                                  color: AppTheme.onSurfaceVariant,
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (canManage) ...[
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (action) async {
                              if (action == 'remove') {
                                await _removeMember(m.uid);
                              } else {
                                await _assignRole(m.uid, action);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'president',
                                child: Text('Make President'),
                              ),
                              const PopupMenuItem(
                                value: 'coordinator',
                                child: Text('Make Coordinator'),
                              ),
                              const PopupMenuItem(
                                value: 'member',
                                child: Text('Set as Member'),
                              ),
                              const PopupMenuItem(
                                value: 'remove',
                                child: Text(
                                  'Remove from Society',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              ],
            ),
    );
  }
}
