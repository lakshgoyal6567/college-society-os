import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String name,
    required String email,
    @JsonKey(name: 'profile_url') @Default('') String profileUrl,
    @JsonKey(name: 'is_global_admin') @Default(false) bool isGlobalAdmin,
    @JsonKey(name: 'society_roles')
    @Default({})
    Map<String, String> societyRoles,
    @JsonKey(name: 'phone') @Default('') String phone,
    @JsonKey(name: 'college') @Default('') String college,
    @JsonKey(name: 'is_profile_complete')
    @Default(false)
    bool isProfileComplete,
    @JsonKey(name: 'fcm_token') String? fcmToken,
  }) = _AppUser;


  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
