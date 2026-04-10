import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/event_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/registration_provider.dart';
import '../../models/event.dart';
import '../../theme/app_theme.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../shared/widgets/skeleton_loader.dart';
import '../../shared/analytics/app_analytics.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final String eventId;
  const EventDetailsScreen({super.key, required this.eventId});

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    AppAnalytics.logScreenView('Event Details');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventListAsync = ref.watch(eventListProvider);
    final user = ref.watch(authUserProvider);

    return eventListAsync.when(
      loading: () => const _DetailsSkeleton(),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
      data: (eventList) {
        final event = eventList.firstWhere(
          (e) => e.eventId == widget.eventId,
          orElse: () => throw 'Event not found',
        );
        final price = event.pricing.getPriceFor(user);

        // One-time log of event view
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppAnalytics.logEventView(event.eventId, event.title);
        });

        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  stretch: true,
                  title:
                      innerBoxIsScrolled
                          ? Text(
                              event.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.onSurface,
                                  ),
                            )
                          : null,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [StretchMode.zoomBackground],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        event.details.bannerUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: event.details.bannerUrl,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: AppTheme.surfaceContainerHighest,
                              ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black26,
                                Colors.transparent,
                                Colors.black45,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: _tabController,
                      labelColor: AppTheme.primary,
                      unselectedLabelColor: AppTheme.onSurfaceVariant,
                      indicatorColor: AppTheme.primary,
                      indicatorWeight: 3,
                      labelStyle:
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                      tabs: const [
                        Tab(text: 'OVERVIEW'),
                        Tab(text: 'STAGES'),
                        Tab(text: 'RULES'),
                        Tab(text: 'PRIZES'),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildOverview(event),
                _buildTimeline(event),
                _buildRules(event),
                _buildPrizes(event),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomBar(context, event, price),
        );
      },
    );
  }

  Widget _buildOverview(Event event) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppTheme.surfaceContainerHighest,
                backgroundImage: event.societyLogo.isNotEmpty
                    ? CachedNetworkImageProvider(event.societyLogo)
                    : null,
                child: event.societyLogo.isEmpty
                    ? const Icon(Icons.apartment, color: AppTheme.primary)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ORGANIZED BY',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      event.societyName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const SectionHeader(
            title: 'About the Event',
            subtitle: 'Deep dive into what we have planned',
          ),
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Text(
              event.details.about,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: AppTheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildTimeline(Event event) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: event.details.stages.length,
      itemBuilder: (ctx, i) {
        final stage = event.details.stages[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GlassCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withAlpha(20),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        stage.date.toUpperCase(),
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        stage.desc,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRules(Event event) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: event.details.rules.length,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.verified_user_outlined,
                color: AppTheme.secondary,
                size: 20,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  event.details.rules[i],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrizes(Event event) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: event.details.prizes.length,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GlassCard(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Icon(
                Icons.emoji_events,
                color: AppTheme.tertiaryFixedDim,
                size: 28,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  event.details.prizes[i],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, Event event, int price) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL PRICE',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    price == 0 ? 'FREE' : '₹$price',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: AppButton(
                  text: 'REGISTER NOW',
                  onPressed: () => _handleRegistration(event, price),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRegistration(Event event, int price) {
    if (price == 0) {
      ref
          .read(registrationControllerProvider.notifier)
          .registerFree(event.eventId);
      _showRegistrationFeedback('Registered for Free Ticket!');
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Confirm Registration'),
          content: Text(
            'Registration Fee: ₹$price. How would you like to pay?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref
                    .read(registrationControllerProvider.notifier)
                    .registerCash(event.eventId);
                Navigator.of(ctx).pop();
                _showRegistrationFeedback(
                  'Cash ticket created. Pending verification.',
                );
              },
              child: const Text('CASH (OFFLINE)'),
            ),
            AppButton(
              text: 'PAY ONLINE',
              onPressed: () {
                ref
                    .read(registrationControllerProvider.notifier)
                    .registerOnline(event.eventId);
                Navigator.of(ctx).pop();
                _showRegistrationFeedback('Online registration successful!');
              },
            ),
          ],
        ),
      );
    }
  }

  void _showRegistrationFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.secondary,
        margin: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(color: AppTheme.outlineVariant, width: 0.5),
        ),
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

class _DetailsSkeleton extends StatelessWidget {
  const _DetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SkeletonBox(height: 300, width: double.infinity, borderRadius: 0),
          const SizedBox(height: 24),
          const ProfileSkeleton(), // Reuse parts for similar feel
        ],
      ),
    );
  }
}
