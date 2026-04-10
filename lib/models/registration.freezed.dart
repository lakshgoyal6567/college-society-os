// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Registration {

@JsonKey(name: 'ticket_id') String get ticketId;@JsonKey(name: 'event_id') String get eventId; String get uid;@JsonKey(name: 'payment_method') String get paymentMethod;@JsonKey(name: 'payment_status') String get paymentStatus;@JsonKey(name: 'verified_by') String? get verifiedBy;@JsonKey(name: 'checked_in') bool get checkedIn;@JsonKey(name: 'is_notified') bool get isNotified;
/// Create a copy of Registration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationCopyWith<Registration> get copyWith => _$RegistrationCopyWithImpl<Registration>(this as Registration, _$identity);

  /// Serializes this Registration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Registration&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.verifiedBy, verifiedBy) || other.verifiedBy == verifiedBy)&&(identical(other.checkedIn, checkedIn) || other.checkedIn == checkedIn)&&(identical(other.isNotified, isNotified) || other.isNotified == isNotified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticketId,eventId,uid,paymentMethod,paymentStatus,verifiedBy,checkedIn,isNotified);

@override
String toString() {
  return 'Registration(ticketId: $ticketId, eventId: $eventId, uid: $uid, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, verifiedBy: $verifiedBy, checkedIn: $checkedIn, isNotified: $isNotified)';
}


}

/// @nodoc
abstract mixin class $RegistrationCopyWith<$Res>  {
  factory $RegistrationCopyWith(Registration value, $Res Function(Registration) _then) = _$RegistrationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'ticket_id') String ticketId,@JsonKey(name: 'event_id') String eventId, String uid,@JsonKey(name: 'payment_method') String paymentMethod,@JsonKey(name: 'payment_status') String paymentStatus,@JsonKey(name: 'verified_by') String? verifiedBy,@JsonKey(name: 'checked_in') bool checkedIn,@JsonKey(name: 'is_notified') bool isNotified
});




}
/// @nodoc
class _$RegistrationCopyWithImpl<$Res>
    implements $RegistrationCopyWith<$Res> {
  _$RegistrationCopyWithImpl(this._self, this._then);

  final Registration _self;
  final $Res Function(Registration) _then;

/// Create a copy of Registration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticketId = null,Object? eventId = null,Object? uid = null,Object? paymentMethod = null,Object? paymentStatus = null,Object? verifiedBy = freezed,Object? checkedIn = null,Object? isNotified = null,}) {
  return _then(_self.copyWith(
ticketId: null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,verifiedBy: freezed == verifiedBy ? _self.verifiedBy : verifiedBy // ignore: cast_nullable_to_non_nullable
as String?,checkedIn: null == checkedIn ? _self.checkedIn : checkedIn // ignore: cast_nullable_to_non_nullable
as bool,isNotified: null == isNotified ? _self.isNotified : isNotified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Registration].
extension RegistrationPatterns on Registration {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Registration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Registration() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Registration value)  $default,){
final _that = this;
switch (_that) {
case _Registration():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Registration value)?  $default,){
final _that = this;
switch (_that) {
case _Registration() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'ticket_id')  String ticketId, @JsonKey(name: 'event_id')  String eventId,  String uid, @JsonKey(name: 'payment_method')  String paymentMethod, @JsonKey(name: 'payment_status')  String paymentStatus, @JsonKey(name: 'verified_by')  String? verifiedBy, @JsonKey(name: 'checked_in')  bool checkedIn, @JsonKey(name: 'is_notified')  bool isNotified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Registration() when $default != null:
return $default(_that.ticketId,_that.eventId,_that.uid,_that.paymentMethod,_that.paymentStatus,_that.verifiedBy,_that.checkedIn,_that.isNotified);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'ticket_id')  String ticketId, @JsonKey(name: 'event_id')  String eventId,  String uid, @JsonKey(name: 'payment_method')  String paymentMethod, @JsonKey(name: 'payment_status')  String paymentStatus, @JsonKey(name: 'verified_by')  String? verifiedBy, @JsonKey(name: 'checked_in')  bool checkedIn, @JsonKey(name: 'is_notified')  bool isNotified)  $default,) {final _that = this;
switch (_that) {
case _Registration():
return $default(_that.ticketId,_that.eventId,_that.uid,_that.paymentMethod,_that.paymentStatus,_that.verifiedBy,_that.checkedIn,_that.isNotified);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'ticket_id')  String ticketId, @JsonKey(name: 'event_id')  String eventId,  String uid, @JsonKey(name: 'payment_method')  String paymentMethod, @JsonKey(name: 'payment_status')  String paymentStatus, @JsonKey(name: 'verified_by')  String? verifiedBy, @JsonKey(name: 'checked_in')  bool checkedIn, @JsonKey(name: 'is_notified')  bool isNotified)?  $default,) {final _that = this;
switch (_that) {
case _Registration() when $default != null:
return $default(_that.ticketId,_that.eventId,_that.uid,_that.paymentMethod,_that.paymentStatus,_that.verifiedBy,_that.checkedIn,_that.isNotified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Registration implements Registration {
  const _Registration({@JsonKey(name: 'ticket_id') required this.ticketId, @JsonKey(name: 'event_id') required this.eventId, required this.uid, @JsonKey(name: 'payment_method') required this.paymentMethod, @JsonKey(name: 'payment_status') required this.paymentStatus, @JsonKey(name: 'verified_by') this.verifiedBy, @JsonKey(name: 'checked_in') this.checkedIn = false, @JsonKey(name: 'is_notified') this.isNotified = false});
  factory _Registration.fromJson(Map<String, dynamic> json) => _$RegistrationFromJson(json);

@override@JsonKey(name: 'ticket_id') final  String ticketId;
@override@JsonKey(name: 'event_id') final  String eventId;
@override final  String uid;
@override@JsonKey(name: 'payment_method') final  String paymentMethod;
@override@JsonKey(name: 'payment_status') final  String paymentStatus;
@override@JsonKey(name: 'verified_by') final  String? verifiedBy;
@override@JsonKey(name: 'checked_in') final  bool checkedIn;
@override@JsonKey(name: 'is_notified') final  bool isNotified;

/// Create a copy of Registration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationCopyWith<_Registration> get copyWith => __$RegistrationCopyWithImpl<_Registration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegistrationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Registration&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.verifiedBy, verifiedBy) || other.verifiedBy == verifiedBy)&&(identical(other.checkedIn, checkedIn) || other.checkedIn == checkedIn)&&(identical(other.isNotified, isNotified) || other.isNotified == isNotified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticketId,eventId,uid,paymentMethod,paymentStatus,verifiedBy,checkedIn,isNotified);

@override
String toString() {
  return 'Registration(ticketId: $ticketId, eventId: $eventId, uid: $uid, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, verifiedBy: $verifiedBy, checkedIn: $checkedIn, isNotified: $isNotified)';
}


}

/// @nodoc
abstract mixin class _$RegistrationCopyWith<$Res> implements $RegistrationCopyWith<$Res> {
  factory _$RegistrationCopyWith(_Registration value, $Res Function(_Registration) _then) = __$RegistrationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'ticket_id') String ticketId,@JsonKey(name: 'event_id') String eventId, String uid,@JsonKey(name: 'payment_method') String paymentMethod,@JsonKey(name: 'payment_status') String paymentStatus,@JsonKey(name: 'verified_by') String? verifiedBy,@JsonKey(name: 'checked_in') bool checkedIn,@JsonKey(name: 'is_notified') bool isNotified
});




}
/// @nodoc
class __$RegistrationCopyWithImpl<$Res>
    implements _$RegistrationCopyWith<$Res> {
  __$RegistrationCopyWithImpl(this._self, this._then);

  final _Registration _self;
  final $Res Function(_Registration) _then;

/// Create a copy of Registration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticketId = null,Object? eventId = null,Object? uid = null,Object? paymentMethod = null,Object? paymentStatus = null,Object? verifiedBy = freezed,Object? checkedIn = null,Object? isNotified = null,}) {
  return _then(_Registration(
ticketId: null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,verifiedBy: freezed == verifiedBy ? _self.verifiedBy : verifiedBy // ignore: cast_nullable_to_non_nullable
as String?,checkedIn: null == checkedIn ? _self.checkedIn : checkedIn // ignore: cast_nullable_to_non_nullable
as bool,isNotified: null == isNotified ? _self.isNotified : isNotified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
