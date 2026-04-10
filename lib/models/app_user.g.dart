// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  uid: json['uid'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  profileUrl: json['profile_url'] as String? ?? '',
  isGlobalAdmin: json['is_global_admin'] as bool? ?? false,
  societyRoles:
      (json['society_roles'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  phone: json['phone'] as String? ?? '',
  college: json['college'] as String? ?? '',
  isProfileComplete: json['is_profile_complete'] as bool? ?? false,
  fcmToken: json['fcm_token'] as String?,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'name': instance.name,
  'email': instance.email,
  'profile_url': instance.profileUrl,
  'is_global_admin': instance.isGlobalAdmin,
  'society_roles': instance.societyRoles,
  'phone': instance.phone,
  'college': instance.college,
  'is_profile_complete': instance.isProfileComplete,
  'fcm_token': instance.fcmToken,
};
