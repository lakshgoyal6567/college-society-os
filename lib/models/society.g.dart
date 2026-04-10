// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'society.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Society _$SocietyFromJson(Map<String, dynamic> json) => _Society(
  societyId: json['society_id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  logoUrl: json['logo_url'] as String? ?? '',
  status: json['status'] as String,
  groups:
      (json['groups'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$SocietyToJson(_Society instance) => <String, dynamic>{
  'society_id': instance.societyId,
  'name': instance.name,
  'description': instance.description,
  'logo_url': instance.logoUrl,
  'status': instance.status,
  'groups': instance.groups,
};

_SocietyRequest _$SocietyRequestFromJson(Map<String, dynamic> json) =>
    _SocietyRequest(
      requestId: json['request_id'] as String,
      action: json['action'] as String,
      societyName: json['society_name'] as String,
      requestedBy: json['requested_by'] as String,
      approvals:
          (json['approvals'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status: json['status'] as String,
    );

Map<String, dynamic> _$SocietyRequestToJson(_SocietyRequest instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'action': instance.action,
      'society_name': instance.societyName,
      'requested_by': instance.requestedBy,
      'approvals': instance.approvals,
      'status': instance.status,
    };
