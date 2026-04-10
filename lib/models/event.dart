import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
abstract class EventPricing with _$EventPricing {
  const factory EventPricing({
    @JsonKey(name: 'is_free') @Default(false) bool isFree,
    @JsonKey(name: 'internal_price') @Default(0) int internalPrice,
    @JsonKey(name: 'external_price') @Default(0) int externalPrice,
  }) = _EventPricing;

  factory EventPricing.fromJson(Map<String, dynamic> json) =>
      _$EventPricingFromJson(json);
}

@freezed
abstract class EventStage with _$EventStage {
  const factory EventStage({
    required String title,
    required String date,
    required String desc,
  }) = _EventStage;

  factory EventStage.fromJson(Map<String, dynamic> json) =>
      _$EventStageFromJson(json);
}

@freezed
abstract class EventDetails with _$EventDetails {
  const factory EventDetails({
    @JsonKey(name: 'banner_url') @Default('') String bannerUrl,
    @Default('') String about,
    @Default([]) List<EventStage> stages,
    @Default([]) List<String> rules,
    @Default([]) List<String> prizes,
  }) = _EventDetails;

  factory EventDetails.fromJson(Map<String, dynamic> json) =>
      _$EventDetailsFromJson(json);
}

@freezed
abstract class Event with _$Event {
  const factory Event({
    @JsonKey(name: 'event_id') required String eventId,
    @JsonKey(name: 'society_id') required String societyId,
    @JsonKey(name: 'society_name')
    @Default('Unknown Society')
    String societyName,
    @JsonKey(name: 'society_logo') @Default('') String societyLogo,
    required String title,
    required String visibility,
    required EventPricing pricing,
    required EventDetails details,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
