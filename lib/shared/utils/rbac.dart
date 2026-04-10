import '../../models/app_user.dart';

/// Role-Based Access Control helpers for TIT&S.
///
/// Usage:
/// ```dart
/// final user = ref.watch(authUserProvider);
/// if (user.canCreateEvent('soc_123')) { ... }
/// ```
extension RbacExtension on AppUser? {
  /// True for global admins.
  bool get isGlobalAdmin => this?.isGlobalAdmin ?? false;

  /// True if the user holds 'president' role in ANY society.
  bool get isPresident =>
      this?.societyRoles.values.contains('president') ?? false;

  /// True if the user holds 'coordinator' role in ANY society.
  bool get isCoordinator =>
      this?.societyRoles.values.contains('coordinator') ?? false;

  /// True if the user holds any elevated role (admin, president, or coordinator).
  bool get hasElevatedRole => isGlobalAdmin || isPresident || isCoordinator;

  /// The society ID where the user is president, or null.
  String? get presidentSocietyId {
    final entry = this?.societyRoles.entries.cast<MapEntry<String, String>?>().firstWhere(
      (e) => e?.value == 'president',
      orElse: () => null,
    );
    return entry?.key;
  }

  /// Returns true if the user can create/edit/delete events for [societyId].
  /// Global admins can manage ALL societies.
  bool canCreateEvent(String societyId) =>
      isGlobalAdmin || (this?.societyRoles[societyId] == 'president');

  /// Returns true if the user can verify cash payments for [societyId].
  bool canVerifyCash(String societyId) =>
      isGlobalAdmin ||
      (this?.societyRoles[societyId] == 'president') ||
      (this?.societyRoles[societyId] == 'coordinator');

  /// Role display string for UI chips.
  String roleIn(String societyId) {
    final role = this?.societyRoles[societyId];
    if (role == null) return 'Member';
    return role[0].toUpperCase() + role.substring(1);
  }
}
