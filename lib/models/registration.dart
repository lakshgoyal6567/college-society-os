import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration.freezed.dart';
part 'registration.g.dart';

@freezed
abstract class Registration with _$Registration {
  const factory Registration({
    @JsonKey(name: 'ticket_id') required String ticketId,
    @JsonKey(name: 'event_id') required String eventId,
    required String uid,
    @JsonKey(name: 'payment_method') required String paymentMethod,
    @JsonKey(name: 'payment_status') required String paymentStatus,
    @JsonKey(name: 'verified_by') String? verifiedBy,
    @JsonKey(name: 'checked_in') @Default(false) bool checkedIn,
    @JsonKey(name: 'is_notified') @Default(false) bool isNotified,
  }) = _Registration;

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);
}
