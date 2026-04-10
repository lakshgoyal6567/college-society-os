import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/event_provider.dart';
import '../../theme/app_theme.dart';
import '../../shared/widgets/app_widgets.dart';
import '../../models/event.dart';
import '../../providers/auth_provider.dart';
import '../../shared/utils/rbac.dart';
import '../admin/create_event_screen.dart';
import 'event_details_screen.dart';
import '../../shared/widgets/skeleton_loader.dart';

class EventFeedScreen extends ConsumerWidget {
  const EventFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(visibleEventsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leadingWidth: (kIsWeb && MediaQuery.of(context).size.width < 800) ? 60 : null,
            leading: (kIsWeb && MediaQuery.of(context).size.width < 800) ? const SizedBox() : null,
            title: Text(
              'Events',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
            backgroundColor: AppTheme.surfaceContainerLowest,
            centerTitle: false,
          ),
          ...eventsAsync.when(
            data:
                (events) =>
                    events.isEmpty
                        ? [
                          const SliverFillRemaining(
                            child: Center(child: Text('No upcoming events.')),
                          ),
                        ]
                        : [
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 450,
                                    crossAxisSpacing: 24,
                                    mainAxisSpacing: 24,
                                    mainAxisExtent: 380,
                                  ),
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                final event = events[index];
                                return EventCard(event: event);
                              }, childCount: events.length),
                            ),
                          ),
                        ],
            loading:
                () => [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 450,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            mainAxisExtent: 380,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return const EventCardSkeleton();
                      }, childCount: 4),
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

class EventCard extends ConsumerWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authUserProvider);
    final canEdit = user.canCreateEvent(event.societyId);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => EventDetailsScreen(eventId: event.eventId),
          ),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: event.details.bannerUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: event.details.bannerUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppTheme.surfaceContainerHighest,
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppTheme.surfaceContainerHighest,
                                child: const Icon(Icons.image_not_supported),
                              ),
                            )
                          : Container(
                              color: AppTheme.primary.withAlpha(20),
                              child: const Center(
                                child: Icon(
                                  Icons.event,
                                  size: 50,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ),
                    ),
                  ),
                  if (canEdit)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit_note_rounded,
                            color: AppTheme.primary,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (ctx) =>
                                        CreateEventScreen(existingEvent: event),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        event.visibility.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Details
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: AppTheme.surfaceContainerHighest,
                          backgroundImage: event.societyLogo.isNotEmpty
                              ? CachedNetworkImageProvider(event.societyLogo)
                              : null,
                          child: event.societyLogo.isEmpty
                              ? const Icon(Icons.group, size: 10)
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            event.societyName,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event.details.about,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
