import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/society.dart';
import '../models/app_user.dart';
import 'auth_provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/services/cache_service.dart';

part 'society_provider.g.dart';

/// Stream of all society_requests — used by the Admin Dashboard.
@riverpod
Stream<List<SocietyRequest>> societyRequests(Ref ref) {
  return FirebaseFirestore.instance
      .collection('society_requests')
      .snapshots()
      .map((snapshot) {
        final requests =
            snapshot.docs
                .map((doc) => SocietyRequest.fromJson(doc.data()))
                .toList();

        // Cache for offline access
        CacheService.save(
          CacheService.keySocietyRequests,
          requests.map((e) => e.toJson()).toList(),
        );
        return requests;
      });
}

/// Stream of all active societies — used by the Societies screen and Profile.
@riverpod
Stream<List<Society>> societyList(Ref ref) {
  return FirebaseFirestore.instance
      .collection('societies')
      .where('status', isEqualTo: 'active')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          data['society_id'] = doc.id;
          return Society.fromJson(data);
        }).toList();
      });
}

@riverpod
class SocietyController extends _$SocietyController {
  @override
  void build() {}

  /// Propose creating a new society. Initiates the consensus voting round.
  Future<void> proposeSociety(String name) async {
    final user = ref.read(authUserProvider);
    if (user == null || !user.isGlobalAdmin) return;

    final id = 'req_${DateTime.now().millisecondsSinceEpoch}';
    final newRequest = SocietyRequest(
      requestId: id,
      action: 'create_society',
      societyName: name,
      requestedBy: user.uid,
      approvals: [user.uid],
      status: 'pending',
    );
    await FirebaseFirestore.instance
        .collection('society_requests')
        .doc(id)
        .set(newRequest.toJson());
  }

  /// Approve a society request. If ALL global admins have approved,
  /// the society doc is created and the request is marked 'approved'.
  Future<void> approveRequest(String requestId) async {
    final user = ref.read(authUserProvider);
    if (user == null || !user.isGlobalAdmin) return;

    final docRef = FirebaseFirestore.instance
        .collection('society_requests')
        .doc(requestId);
    final doc = await docRef.get();
    if (!doc.exists) return;

    final req = SocietyRequest.fromJson(doc.data()!);
    if (req.approvals.contains(user.uid)) return;

    final newApprovals = [...req.approvals, user.uid];

    // Count total global admins to determine consensus
    final adminSnap = await FirebaseFirestore.instance
        .collection('users')
        .where('is_global_admin', isEqualTo: true)
        .get();
    final totalAdmins = adminSnap.size;

    final consensusReached = newApprovals.length >= totalAdmins;
    final newStatus = consensusReached ? 'approved' : 'pending';

    await docRef.update({'approvals': newApprovals, 'status': newStatus});

    // If consensus reached, create the society document
    if (consensusReached) {
      final societyId = 'soc_${DateTime.now().millisecondsSinceEpoch}';
      await FirebaseFirestore.instance
          .collection('societies')
          .doc(societyId)
          .set({
            'society_id': societyId,
            'name': req.societyName,
            'description': '',
            'logo_url': '',
            'status': 'active',
            'groups': <String>[],
          });
    }
  }

  /// Assign a role to a user within a society.
  Future<void> assignRole({
    required String societyId,
    required String uid,
    required String role, // 'president' | 'coordinator' | 'member'
  }) async {
    final caller = ref.read(authUserProvider);
    if (caller == null || !caller.isGlobalAdmin) {
      throw Exception('Only Global Admins can assign society roles.');
    }

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'society_roles.$societyId': role,
    });
  }

  /// Remove a user's role from a society.
  Future<void> removeMember({
    required String societyId,
    required String uid,
  }) async {
    final caller = ref.read(authUserProvider);
    if (caller == null) return;
    final isPresident = caller.societyRoles[societyId] == 'president';
    if (!caller.isGlobalAdmin && !isPresident) return;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'society_roles.$societyId': FieldValue.delete(),
    });
  }

  /// Get all members of a society (users whose society_roles contains societyId).
  Future<List<AppUser>> getSocietyMembers(String societyId) async {
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .where('society_roles.$societyId', isGreaterThan: '')
        .get();

    return snap.docs.map((doc) => AppUser.fromJson(doc.data())).toList();
  }
}
