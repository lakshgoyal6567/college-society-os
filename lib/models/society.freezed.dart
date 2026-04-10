// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'society.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Society {

@JsonKey(name: 'society_id') String get societyId; String get name; String get description;@JsonKey(name: 'logo_url') String get logoUrl; String get status; List<String> get groups;
/// Create a copy of Society
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocietyCopyWith<Society> get copyWith => _$SocietyCopyWithImpl<Society>(this as Society, _$identity);

  /// Serializes this Society to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Society&&(identical(other.societyId, societyId) || other.societyId == societyId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.groups, groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,societyId,name,description,logoUrl,status,const DeepCollectionEquality().hash(groups));

@override
String toString() {
  return 'Society(societyId: $societyId, name: $name, description: $description, logoUrl: $logoUrl, status: $status, groups: $groups)';
}


}

/// @nodoc
abstract mixin class $SocietyCopyWith<$Res>  {
  factory $SocietyCopyWith(Society value, $Res Function(Society) _then) = _$SocietyCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'society_id') String societyId, String name, String description,@JsonKey(name: 'logo_url') String logoUrl, String status, List<String> groups
});




}
/// @nodoc
class _$SocietyCopyWithImpl<$Res>
    implements $SocietyCopyWith<$Res> {
  _$SocietyCopyWithImpl(this._self, this._then);

  final Society _self;
  final $Res Function(Society) _then;

/// Create a copy of Society
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? societyId = null,Object? name = null,Object? description = null,Object? logoUrl = null,Object? status = null,Object? groups = null,}) {
  return _then(_self.copyWith(
societyId: null == societyId ? _self.societyId : societyId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,logoUrl: null == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Society].
extension SocietyPatterns on Society {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Society value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Society() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Society value)  $default,){
final _that = this;
switch (_that) {
case _Society():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Society value)?  $default,){
final _that = this;
switch (_that) {
case _Society() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'society_id')  String societyId,  String name,  String description, @JsonKey(name: 'logo_url')  String logoUrl,  String status,  List<String> groups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Society() when $default != null:
return $default(_that.societyId,_that.name,_that.description,_that.logoUrl,_that.status,_that.groups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'society_id')  String societyId,  String name,  String description, @JsonKey(name: 'logo_url')  String logoUrl,  String status,  List<String> groups)  $default,) {final _that = this;
switch (_that) {
case _Society():
return $default(_that.societyId,_that.name,_that.description,_that.logoUrl,_that.status,_that.groups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'society_id')  String societyId,  String name,  String description, @JsonKey(name: 'logo_url')  String logoUrl,  String status,  List<String> groups)?  $default,) {final _that = this;
switch (_that) {
case _Society() when $default != null:
return $default(_that.societyId,_that.name,_that.description,_that.logoUrl,_that.status,_that.groups);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Society implements Society {
  const _Society({@JsonKey(name: 'society_id') required this.societyId, required this.name, required this.description, @JsonKey(name: 'logo_url') this.logoUrl = '', required this.status, final  List<String> groups = const []}): _groups = groups;
  factory _Society.fromJson(Map<String, dynamic> json) => _$SocietyFromJson(json);

@override@JsonKey(name: 'society_id') final  String societyId;
@override final  String name;
@override final  String description;
@override@JsonKey(name: 'logo_url') final  String logoUrl;
@override final  String status;
 final  List<String> _groups;
@override@JsonKey() List<String> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}


/// Create a copy of Society
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocietyCopyWith<_Society> get copyWith => __$SocietyCopyWithImpl<_Society>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocietyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Society&&(identical(other.societyId, societyId) || other.societyId == societyId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._groups, _groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,societyId,name,description,logoUrl,status,const DeepCollectionEquality().hash(_groups));

@override
String toString() {
  return 'Society(societyId: $societyId, name: $name, description: $description, logoUrl: $logoUrl, status: $status, groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$SocietyCopyWith<$Res> implements $SocietyCopyWith<$Res> {
  factory _$SocietyCopyWith(_Society value, $Res Function(_Society) _then) = __$SocietyCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'society_id') String societyId, String name, String description,@JsonKey(name: 'logo_url') String logoUrl, String status, List<String> groups
});




}
/// @nodoc
class __$SocietyCopyWithImpl<$Res>
    implements _$SocietyCopyWith<$Res> {
  __$SocietyCopyWithImpl(this._self, this._then);

  final _Society _self;
  final $Res Function(_Society) _then;

/// Create a copy of Society
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? societyId = null,Object? name = null,Object? description = null,Object? logoUrl = null,Object? status = null,Object? groups = null,}) {
  return _then(_Society(
societyId: null == societyId ? _self.societyId : societyId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,logoUrl: null == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$SocietyRequest {

@JsonKey(name: 'request_id') String get requestId; String get action;@JsonKey(name: 'society_name') String get societyName;@JsonKey(name: 'requested_by') String get requestedBy; List<String> get approvals; String get status;
/// Create a copy of SocietyRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocietyRequestCopyWith<SocietyRequest> get copyWith => _$SocietyRequestCopyWithImpl<SocietyRequest>(this as SocietyRequest, _$identity);

  /// Serializes this SocietyRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocietyRequest&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.action, action) || other.action == action)&&(identical(other.societyName, societyName) || other.societyName == societyName)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&const DeepCollectionEquality().equals(other.approvals, approvals)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,action,societyName,requestedBy,const DeepCollectionEquality().hash(approvals),status);

@override
String toString() {
  return 'SocietyRequest(requestId: $requestId, action: $action, societyName: $societyName, requestedBy: $requestedBy, approvals: $approvals, status: $status)';
}


}

/// @nodoc
abstract mixin class $SocietyRequestCopyWith<$Res>  {
  factory $SocietyRequestCopyWith(SocietyRequest value, $Res Function(SocietyRequest) _then) = _$SocietyRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'request_id') String requestId, String action,@JsonKey(name: 'society_name') String societyName,@JsonKey(name: 'requested_by') String requestedBy, List<String> approvals, String status
});




}
/// @nodoc
class _$SocietyRequestCopyWithImpl<$Res>
    implements $SocietyRequestCopyWith<$Res> {
  _$SocietyRequestCopyWithImpl(this._self, this._then);

  final SocietyRequest _self;
  final $Res Function(SocietyRequest) _then;

/// Create a copy of SocietyRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = null,Object? action = null,Object? societyName = null,Object? requestedBy = null,Object? approvals = null,Object? status = null,}) {
  return _then(_self.copyWith(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,societyName: null == societyName ? _self.societyName : societyName // ignore: cast_nullable_to_non_nullable
as String,requestedBy: null == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as String,approvals: null == approvals ? _self.approvals : approvals // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SocietyRequest].
extension SocietyRequestPatterns on SocietyRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocietyRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocietyRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocietyRequest value)  $default,){
final _that = this;
switch (_that) {
case _SocietyRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocietyRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SocietyRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'request_id')  String requestId,  String action, @JsonKey(name: 'society_name')  String societyName, @JsonKey(name: 'requested_by')  String requestedBy,  List<String> approvals,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocietyRequest() when $default != null:
return $default(_that.requestId,_that.action,_that.societyName,_that.requestedBy,_that.approvals,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'request_id')  String requestId,  String action, @JsonKey(name: 'society_name')  String societyName, @JsonKey(name: 'requested_by')  String requestedBy,  List<String> approvals,  String status)  $default,) {final _that = this;
switch (_that) {
case _SocietyRequest():
return $default(_that.requestId,_that.action,_that.societyName,_that.requestedBy,_that.approvals,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'request_id')  String requestId,  String action, @JsonKey(name: 'society_name')  String societyName, @JsonKey(name: 'requested_by')  String requestedBy,  List<String> approvals,  String status)?  $default,) {final _that = this;
switch (_that) {
case _SocietyRequest() when $default != null:
return $default(_that.requestId,_that.action,_that.societyName,_that.requestedBy,_that.approvals,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocietyRequest implements SocietyRequest {
  const _SocietyRequest({@JsonKey(name: 'request_id') required this.requestId, required this.action, @JsonKey(name: 'society_name') required this.societyName, @JsonKey(name: 'requested_by') required this.requestedBy, final  List<String> approvals = const [], required this.status}): _approvals = approvals;
  factory _SocietyRequest.fromJson(Map<String, dynamic> json) => _$SocietyRequestFromJson(json);

@override@JsonKey(name: 'request_id') final  String requestId;
@override final  String action;
@override@JsonKey(name: 'society_name') final  String societyName;
@override@JsonKey(name: 'requested_by') final  String requestedBy;
 final  List<String> _approvals;
@override@JsonKey() List<String> get approvals {
  if (_approvals is EqualUnmodifiableListView) return _approvals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_approvals);
}

@override final  String status;

/// Create a copy of SocietyRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocietyRequestCopyWith<_SocietyRequest> get copyWith => __$SocietyRequestCopyWithImpl<_SocietyRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocietyRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocietyRequest&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.action, action) || other.action == action)&&(identical(other.societyName, societyName) || other.societyName == societyName)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&const DeepCollectionEquality().equals(other._approvals, _approvals)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,action,societyName,requestedBy,const DeepCollectionEquality().hash(_approvals),status);

@override
String toString() {
  return 'SocietyRequest(requestId: $requestId, action: $action, societyName: $societyName, requestedBy: $requestedBy, approvals: $approvals, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SocietyRequestCopyWith<$Res> implements $SocietyRequestCopyWith<$Res> {
  factory _$SocietyRequestCopyWith(_SocietyRequest value, $Res Function(_SocietyRequest) _then) = __$SocietyRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'request_id') String requestId, String action,@JsonKey(name: 'society_name') String societyName,@JsonKey(name: 'requested_by') String requestedBy, List<String> approvals, String status
});




}
/// @nodoc
class __$SocietyRequestCopyWithImpl<$Res>
    implements _$SocietyRequestCopyWith<$Res> {
  __$SocietyRequestCopyWithImpl(this._self, this._then);

  final _SocietyRequest _self;
  final $Res Function(_SocietyRequest) _then;

/// Create a copy of SocietyRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? action = null,Object? societyName = null,Object? requestedBy = null,Object? approvals = null,Object? status = null,}) {
  return _then(_SocietyRequest(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,societyName: null == societyName ? _self.societyName : societyName // ignore: cast_nullable_to_non_nullable
as String,requestedBy: null == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as String,approvals: null == approvals ? _self._approvals : approvals // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
