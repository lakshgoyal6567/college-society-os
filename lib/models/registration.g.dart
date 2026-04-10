// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Registration _$RegistrationFromJson(Map<String, dynamic> json) =>
    _Registration(
      ticketId: json['ticket_id'] as String,
      eventId: json['event_id'] as String,
      uid: json['uid'] as String,
      paymentMethod: json['payment_method'] as String,
      paymentStatus: json['payment_status'] as String,
      verifiedBy: json['verified_by'] as String?,
      checkedIn: json['checked_in'] as bool? ?? false,
      isNotified: json['is_notified'] as bool? ?? false,
    );

Map<String, dynamic> _$RegistrationToJson(_Registration instance) =>
    <String, dynamic>{
      'ticket_id': instance.ticketId,
      'event_id': instance.eventId,
      'uid': instance.uid,
      'payment_method': instance.paymentMethod,
      'payment_status': instance.paymentStatus,
      'verified_by': instance.verifiedBy,
      'checked_in': instance.checkedIn,
      'is_notified': instance.isNotified,
    };
