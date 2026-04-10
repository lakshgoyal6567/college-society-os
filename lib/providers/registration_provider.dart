import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/registration.dart';
import 'auth_provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/services/cache_service.dart';
import '../shared/analytics/app_analytics.dart';

part 'registration_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<List<Registration>> registrations(Ref ref) {
  final user = ref.watch(authUserProvider);

  if (user == null) {
    return Stream.value([]);
  }

  return FirebaseFirestore.instance
      .collection('registrations')
      .where('uid', isEqualTo: user.uid)
      .snapshots()
      .map((snapshot) {
        final regs =
            snapshot.docs
                .map((doc) => Registration.fromJson(doc.data()))
                .toList();

        // Save to cache
        CacheService.save(
          CacheService.keyRegistrations,
          regs.map((e) => e.toJson()).toList(),
        );
        return regs;
      });
}

@riverpod
class RegistrationController extends _$RegistrationController {
  @override
  void build() {}

  Future<void> registerFree(String eventId) async {
    final user = ref.read(authUserProvider);
    if (user == null) return;

    final reg = Registration(
      ticketId: 'qr_free_${DateTime.now().millisecondsSinceEpoch}',
      eventId: eventId,
      uid: user.uid,
      paymentMethod: 'none',
      paymentStatus: 'free',
      checkedIn: false,
    );
    await FirebaseFirestore.instance
        .collection('registrations')
        .doc(reg.ticketId)
        .set(reg.toJson());

    await AppAnalytics.logRegistration(eventId, 'online');
  }

  Future<void> registerOnline(String eventId) async {
    final user = ref.read(authUserProvider);
    if (user == null) return;

    final reg = Registration(
      ticketId: 'qr_onl_${DateTime.now().millisecondsSinceEpoch}',
      eventId: eventId,
      uid: user.uid,
      paymentMethod: 'online',
      paymentStatus: 'verified',
      checkedIn: false,
    );
    await FirebaseFirestore.instance
        .collection('registrations')
        .doc(reg.ticketId)
        .set(reg.toJson());

    await AppAnalytics.logRegistration(eventId, 'online');
  }

  Future<void> registerCash(String eventId) async {
    final user = ref.read(authUserProvider);
    if (user == null) return;

    final reg = Registration(
      ticketId: 'qr_csh_${DateTime.now().millisecondsSinceEpoch}',
      eventId: eventId,
      uid: user.uid,
      paymentMethod: 'cash',
      paymentStatus: 'pending_cash',
      checkedIn: false,
    );
    await FirebaseFirestore.instance
        .collection('registrations')
        .doc(reg.ticketId)
        .set(reg.toJson());

    await AppAnalytics.logRegistration(eventId, 'cash');
  }

  Future<Registration?> findTicketOnline(String ticketId) async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('registrations')
              .doc(ticketId)
              .get();
      if (!doc.exists) return null;
      return Registration.fromJson(doc.data()!);
    } catch (e) {
      return null;
    }
  }

  Future<void> verifyCashPayment(String ticketId) async {
    final coordinator = ref.read(authUserProvider);
    if (coordinator == null) return;

    // Use snake_case keys to match the Firestore document schema
    // (payment_status, verified_by are stored as snake_case via freezed)
    await FirebaseFirestore.instance
        .collection('registrations')
        .doc(ticketId)
        .update({
          'payment_status': 'verified',
          'verified_by': coordinator.uid,
        });
  }

  Future<void> markAsNotified(String ticketId) async {
    await FirebaseFirestore.instance
        .collection('registrations')
        .doc(ticketId)
        .update({'is_notified': true});
  }

  Future<void> checkIn(String ticketId) async {
    // Use snake_case key to match the Firestore schema
    await FirebaseFirestore.instance
        .collection('registrations')
        .doc(ticketId)
        .update({'checked_in': true});
  }
}
