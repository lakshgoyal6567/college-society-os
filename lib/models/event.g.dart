// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventPricing _$EventPricingFromJson(Map<String, dynamic> json) =>
    _EventPricing(
      isFree: json['is_free'] as bool? ?? false,
      internalPrice: (json['internal_price'] as num?)?.toInt() ?? 0,
      externalPrice: (json['external_price'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$EventPricingToJson(_EventPricing instance) =>
    <String, dynamic>{
      'is_free': instance.isFree,
      'internal_price': instance.internalPrice,
      'external_price': instance.externalPrice,
    };

_EventStage _$EventStageFromJson(Map<String, dynamic> json) => _EventStage(
  title: json['title'] as String,
  date: json['date'] as String,
  desc: json['desc'] as String,
);

Map<String, dynamic> _$EventStageToJson(_EventStage instance) =>
    <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'desc': instance.desc,
    };

_EventDetails _$EventDetailsFromJson(Map<String, dynamic> json) =>
    _EventDetails(
      bannerUrl: json['banner_url'] as String? ?? '',
      about: json['about'] as String? ?? '',
      stages:
          (json['stages'] as List<dynamic>?)
              ?.map((e) => EventStage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rules:
          (json['rules'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      prizes:
          (json['prizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$EventDetailsToJson(_EventDetails instance) =>
    <String, dynamic>{
      'banner_url': instance.bannerUrl,
      'about': instance.about,
      'stages': instance.stages,
      'rules': instance.rules,
      'prizes': instance.prizes,
    };

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  eventId: json['event_id'] as String,
  societyId: json['society_id'] as String,
  societyName: json['society_name'] as String? ?? 'Unknown Society',
  societyLogo: json['society_logo'] as String? ?? '',
  title: json['title'] as String,
  visibility: json['visibility'] as String,
  pricing: EventPricing.fromJson(json['pricing'] as Map<String, dynamic>),
  details: EventDetails.fromJson(json['details'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'event_id': instance.eventId,
  'society_id': instance.societyId,
  'society_name': instance.societyName,
  'society_logo': instance.societyLogo,
  'title': instance.title,
  'visibility': instance.visibility,
  'pricing': instance.pricing,
  'details': instance.details,
};
