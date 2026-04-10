import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/event.dart';
import '../models/app_user.dart';
import 'auth_provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../shared/services/cache_service.dart';

part 'event_provider.g.dart';

@riverpod
Stream<List<Event>> eventList(Ref ref) {
  return FirebaseFirestore.instance
      .collection('events')
      .snapshots()
      .map((snapshot) {
    final events =
        snapshot.docs.map((doc) {
          final data = doc.data();
          data['event_id'] = doc.id;
          return Event.fromJson(data);
        }).toList();

    // Save to cache in background
    CacheService.save(
      CacheService.keyEvents,
      events.map((e) => e.toJson()).toList(),
    );

    return events;
  });
}

@riverpod
AsyncValue<List<Event>> visibleEvents(Ref ref) {
  final eventListAsync = ref.watch(eventListProvider);
  final user = ref.watch(authUserProvider);

  return eventListAsync.whenData((events) {
    return events.where((event) {
      if (event.visibility == 'open') return true;
      if (event.visibility == 'college') {
        return user?.email.endsWith('@yourcollege.edu.in') ?? false;
      }
      if (event.visibility == 'society') {
        return user?.societyRoles.containsKey(event.societyId) ?? false;
      }
      return false;
    }).toList();
  });
}

extension EventPricingContext on EventPricing {
  int getPriceFor(AppUser? user) {
    if (isFree) {
      return 0;
    }
    if (user != null && user.email.endsWith('@yourcollege.edu.in')) {
      return internalPrice;
    }
    return externalPrice;
  }
}

/// CRUD controller for events. Only Global Admins and Presidents can
/// create/update/delete events.
@riverpod
class EventController extends _$EventController {
  @override
  void build() {}

  Future<void> createEvent(Event event) async {
    final user = ref.read(authUserProvider);
    if (user == null) return;
    if (!user.isGlobalAdmin &&
        user.societyRoles[event.societyId] != 'president') {
      throw Exception('Insufficient permissions to create event.');
    }

    final docRef =
        FirebaseFirestore.instance.collection('events').doc();
    final withId = event.copyWith(eventId: docRef.id);
    await docRef.set(withId.toJson());
  }

  Future<void> updateEvent(Event event) async {
    final user = ref.read(authUserProvider);
    if (user == null) return;
    if (!user.isGlobalAdmin &&
        user.societyRoles[event.societyId] != 'president') {
      throw Exception('Insufficient permissions to update event.');
    }

    await FirebaseFirestore.instance
        .collection('events')
        .doc(event.eventId)
        .set(event.toJson());
  }

  Future<void> deleteEvent(String eventId, String societyId) async {
    final user = ref.read(authUserProvider);
    if (user == null) return;
    if (!user.isGlobalAdmin &&
        user.societyRoles[societyId] != 'president') {
      throw Exception('Insufficient permissions to delete event.');
    }

    await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .delete();
  }
}
