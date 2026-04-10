// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventPricing {

@JsonKey(name: 'is_free') bool get isFree;@JsonKey(name: 'internal_price') int get internalPrice;@JsonKey(name: 'external_price') int get externalPrice;
/// Create a copy of EventPricing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventPricingCopyWith<EventPricing> get copyWith => _$EventPricingCopyWithImpl<EventPricing>(this as EventPricing, _$identity);

  /// Serializes this EventPricing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventPricing&&(identical(other.isFree, isFree) || other.isFree == isFree)&&(identical(other.internalPrice, internalPrice) || other.internalPrice == internalPrice)&&(identical(other.externalPrice, externalPrice) || other.externalPrice == externalPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFree,internalPrice,externalPrice);

@override
String toString() {
  return 'EventPricing(isFree: $isFree, internalPrice: $internalPrice, externalPrice: $externalPrice)';
}


}

/// @nodoc
abstract mixin class $EventPricingCopyWith<$Res>  {
  factory $EventPricingCopyWith(EventPricing value, $Res Function(EventPricing) _then) = _$EventPricingCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'is_free') bool isFree,@JsonKey(name: 'internal_price') int internalPrice,@JsonKey(name: 'external_price') int externalPrice
});




}
/// @nodoc
class _$EventPricingCopyWithImpl<$Res>
    implements $EventPricingCopyWith<$Res> {
  _$EventPricingCopyWithImpl(this._self, this._then);

  final EventPricing _self;
  final $Res Function(EventPricing) _then;

/// Create a copy of EventPricing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isFree = null,Object? internalPrice = null,Object? externalPrice = null,}) {
  return _then(_self.copyWith(
isFree: null == isFree ? _self.isFree : isFree // ignore: cast_nullable_to_non_nullable
as bool,internalPrice: null == internalPrice ? _self.internalPrice : internalPrice // ignore: cast_nullable_to_non_nullable
as int,externalPrice: null == externalPrice ? _self.externalPrice : externalPrice // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EventPricing].
extension EventPricingPatterns on EventPricing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventPricing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventPricing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventPricing value)  $default,){
final _that = this;
switch (_that) {
case _EventPricing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventPricing value)?  $default,){
final _that = this;
switch (_that) {
case _EventPricing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_free')  bool isFree, @JsonKey(name: 'internal_price')  int internalPrice, @JsonKey(name: 'external_price')  int externalPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventPricing() when $default != null:
return $default(_that.isFree,_that.internalPrice,_that.externalPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_free')  bool isFree, @JsonKey(name: 'internal_price')  int internalPrice, @JsonKey(name: 'external_price')  int externalPrice)  $default,) {final _that = this;
switch (_that) {
case _EventPricing():
return $default(_that.isFree,_that.internalPrice,_that.externalPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'is_free')  bool isFree, @JsonKey(name: 'internal_price')  int internalPrice, @JsonKey(name: 'external_price')  int externalPrice)?  $default,) {final _that = this;
switch (_that) {
case _EventPricing() when $default != null:
return $default(_that.isFree,_that.internalPrice,_that.externalPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventPricing implements EventPricing {
  const _EventPricing({@JsonKey(name: 'is_free') this.isFree = false, @JsonKey(name: 'internal_price') this.internalPrice = 0, @JsonKey(name: 'external_price') this.externalPrice = 0});
  factory _EventPricing.fromJson(Map<String, dynamic> json) => _$EventPricingFromJson(json);

@override@JsonKey(name: 'is_free') final  bool isFree;
@override@JsonKey(name: 'internal_price') final  int internalPrice;
@override@JsonKey(name: 'external_price') final  int externalPrice;

/// Create a copy of EventPricing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventPricingCopyWith<_EventPricing> get copyWith => __$EventPricingCopyWithImpl<_EventPricing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventPricingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPricing&&(identical(other.isFree, isFree) || other.isFree == isFree)&&(identical(other.internalPrice, internalPrice) || other.internalPrice == internalPrice)&&(identical(other.externalPrice, externalPrice) || other.externalPrice == externalPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFree,internalPrice,externalPrice);

@override
String toString() {
  return 'EventPricing(isFree: $isFree, internalPrice: $internalPrice, externalPrice: $externalPrice)';
}


}

/// @nodoc
abstract mixin class _$EventPricingCopyWith<$Res> implements $EventPricingCopyWith<$Res> {
  factory _$EventPricingCopyWith(_EventPricing value, $Res Function(_EventPricing) _then) = __$EventPricingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'is_free') bool isFree,@JsonKey(name: 'internal_price') int internalPrice,@JsonKey(name: 'external_price') int externalPrice
});




}
/// @nodoc
class __$EventPricingCopyWithImpl<$Res>
    implements _$EventPricingCopyWith<$Res> {
  __$EventPricingCopyWithImpl(this._self, this._then);

  final _EventPricing _self;
  final $Res Function(_EventPricing) _then;

/// Create a copy of EventPricing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isFree = null,Object? internalPrice = null,Object? externalPrice = null,}) {
  return _then(_EventPricing(
isFree: null == isFree ? _self.isFree : isFree // ignore: cast_nullable_to_non_nullable
as bool,internalPrice: null == internalPrice ? _self.internalPrice : internalPrice // ignore: cast_nullable_to_non_nullable
as int,externalPrice: null == externalPrice ? _self.externalPrice : externalPrice // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$EventStage {

 String get title; String get date; String get desc;
/// Create a copy of EventStage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventStageCopyWith<EventStage> get copyWith => _$EventStageCopyWithImpl<EventStage>(this as EventStage, _$identity);

  /// Serializes this EventStage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventStage&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,desc);

@override
String toString() {
  return 'EventStage(title: $title, date: $date, desc: $desc)';
}


}

/// @nodoc
abstract mixin class $EventStageCopyWith<$Res>  {
  factory $EventStageCopyWith(EventStage value, $Res Function(EventStage) _then) = _$EventStageCopyWithImpl;
@useResult
$Res call({
 String title, String date, String desc
});




}
/// @nodoc
class _$EventStageCopyWithImpl<$Res>
    implements $EventStageCopyWith<$Res> {
  _$EventStageCopyWithImpl(this._self, this._then);

  final EventStage _self;
  final $Res Function(EventStage) _then;

/// Create a copy of EventStage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? date = null,Object? desc = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EventStage].
extension EventStagePatterns on EventStage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventStage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventStage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventStage value)  $default,){
final _that = this;
switch (_that) {
case _EventStage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventStage value)?  $default,){
final _that = this;
switch (_that) {
case _EventStage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String date,  String desc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventStage() when $default != null:
return $default(_that.title,_that.date,_that.desc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String date,  String desc)  $default,) {final _that = this;
switch (_that) {
case _EventStage():
return $default(_that.title,_that.date,_that.desc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String date,  String desc)?  $default,) {final _that = this;
switch (_that) {
case _EventStage() when $default != null:
return $default(_that.title,_that.date,_that.desc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventStage implements EventStage {
  const _EventStage({required this.title, required this.date, required this.desc});
  factory _EventStage.fromJson(Map<String, dynamic> json) => _$EventStageFromJson(json);

@override final  String title;
@override final  String date;
@override final  String desc;

/// Create a copy of EventStage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventStageCopyWith<_EventStage> get copyWith => __$EventStageCopyWithImpl<_EventStage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventStageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventStage&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.desc, desc) || other.desc == desc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,date,desc);

@override
String toString() {
  return 'EventStage(title: $title, date: $date, desc: $desc)';
}


}

/// @nodoc
abstract mixin class _$EventStageCopyWith<$Res> implements $EventStageCopyWith<$Res> {
  factory _$EventStageCopyWith(_EventStage value, $Res Function(_EventStage) _then) = __$EventStageCopyWithImpl;
@override @useResult
$Res call({
 String title, String date, String desc
});




}
/// @nodoc
class __$EventStageCopyWithImpl<$Res>
    implements _$EventStageCopyWith<$Res> {
  __$EventStageCopyWithImpl(this._self, this._then);

  final _EventStage _self;
  final $Res Function(_EventStage) _then;

/// Create a copy of EventStage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? date = null,Object? desc = null,}) {
  return _then(_EventStage(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EventDetails {

@JsonKey(name: 'banner_url') String get bannerUrl; String get about; List<EventStage> get stages; List<String> get rules; List<String> get prizes;
/// Create a copy of EventDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDetailsCopyWith<EventDetails> get copyWith => _$EventDetailsCopyWithImpl<EventDetails>(this as EventDetails, _$identity);

  /// Serializes this EventDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetails&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other.stages, stages)&&const DeepCollectionEquality().equals(other.rules, rules)&&const DeepCollectionEquality().equals(other.prizes, prizes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bannerUrl,about,const DeepCollectionEquality().hash(stages),const DeepCollectionEquality().hash(rules),const DeepCollectionEquality().hash(prizes));

@override
String toString() {
  return 'EventDetails(bannerUrl: $bannerUrl, about: $about, stages: $stages, rules: $rules, prizes: $prizes)';
}


}

/// @nodoc
abstract mixin class $EventDetailsCopyWith<$Res>  {
  factory $EventDetailsCopyWith(EventDetails value, $Res Function(EventDetails) _then) = _$EventDetailsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'banner_url') String bannerUrl, String about, List<EventStage> stages, List<String> rules, List<String> prizes
});




}
/// @nodoc
class _$EventDetailsCopyWithImpl<$Res>
    implements $EventDetailsCopyWith<$Res> {
  _$EventDetailsCopyWithImpl(this._self, this._then);

  final EventDetails _self;
  final $Res Function(EventDetails) _then;

/// Create a copy of EventDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bannerUrl = null,Object? about = null,Object? stages = null,Object? rules = null,Object? prizes = null,}) {
  return _then(_self.copyWith(
bannerUrl: null == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,stages: null == stages ? _self.stages : stages // ignore: cast_nullable_to_non_nullable
as List<EventStage>,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<String>,prizes: null == prizes ? _self.prizes : prizes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventDetails].
extension EventDetailsPatterns on EventDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDetails value)  $default,){
final _that = this;
switch (_that) {
case _EventDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDetails value)?  $default,){
final _that = this;
switch (_that) {
case _EventDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'banner_url')  String bannerUrl,  String about,  List<EventStage> stages,  List<String> rules,  List<String> prizes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDetails() when $default != null:
return $default(_that.bannerUrl,_that.about,_that.stages,_that.rules,_that.prizes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'banner_url')  String bannerUrl,  String about,  List<EventStage> stages,  List<String> rules,  List<String> prizes)  $default,) {final _that = this;
switch (_that) {
case _EventDetails():
return $default(_that.bannerUrl,_that.about,_that.stages,_that.rules,_that.prizes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'banner_url')  String bannerUrl,  String about,  List<EventStage> stages,  List<String> rules,  List<String> prizes)?  $default,) {final _that = this;
switch (_that) {
case _EventDetails() when $default != null:
return $default(_that.bannerUrl,_that.about,_that.stages,_that.rules,_that.prizes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDetails implements EventDetails {
  const _EventDetails({@JsonKey(name: 'banner_url') this.bannerUrl = '', this.about = '', final  List<EventStage> stages = const [], final  List<String> rules = const [], final  List<String> prizes = const []}): _stages = stages,_rules = rules,_prizes = prizes;
  factory _EventDetails.fromJson(Map<String, dynamic> json) => _$EventDetailsFromJson(json);

@override@JsonKey(name: 'banner_url') final  String bannerUrl;
@override@JsonKey() final  String about;
 final  List<EventStage> _stages;
@override@JsonKey() List<EventStage> get stages {
  if (_stages is EqualUnmodifiableListView) return _stages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stages);
}

 final  List<String> _rules;
@override@JsonKey() List<String> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}

 final  List<String> _prizes;
@override@JsonKey() List<String> get prizes {
  if (_prizes is EqualUnmodifiableListView) return _prizes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prizes);
}


/// Create a copy of EventDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDetailsCopyWith<_EventDetails> get copyWith => __$EventDetailsCopyWithImpl<_EventDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDetails&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.about, about) || other.about == about)&&const DeepCollectionEquality().equals(other._stages, _stages)&&const DeepCollectionEquality().equals(other._rules, _rules)&&const DeepCollectionEquality().equals(other._prizes, _prizes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bannerUrl,about,const DeepCollectionEquality().hash(_stages),const DeepCollectionEquality().hash(_rules),const DeepCollectionEquality().hash(_prizes));

@override
String toString() {
  return 'EventDetails(bannerUrl: $bannerUrl, about: $about, stages: $stages, rules: $rules, prizes: $prizes)';
}


}

/// @nodoc
abstract mixin class _$EventDetailsCopyWith<$Res> implements $EventDetailsCopyWith<$Res> {
  factory _$EventDetailsCopyWith(_EventDetails value, $Res Function(_EventDetails) _then) = __$EventDetailsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'banner_url') String bannerUrl, String about, List<EventStage> stages, List<String> rules, List<String> prizes
});




}
/// @nodoc
class __$EventDetailsCopyWithImpl<$Res>
    implements _$EventDetailsCopyWith<$Res> {
  __$EventDetailsCopyWithImpl(this._self, this._then);

  final _EventDetails _self;
  final $Res Function(_EventDetails) _then;

/// Create a copy of EventDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bannerUrl = null,Object? about = null,Object? stages = null,Object? rules = null,Object? prizes = null,}) {
  return _then(_EventDetails(
bannerUrl: null == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,stages: null == stages ? _self._stages : stages // ignore: cast_nullable_to_non_nullable
as List<EventStage>,rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<String>,prizes: null == prizes ? _self._prizes : prizes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$Event {

@JsonKey(name: 'event_id') String get eventId;@JsonKey(name: 'society_id') String get societyId;@JsonKey(name: 'society_name') String get societyName;@JsonKey(name: 'society_logo') String get societyLogo; String get title; String get visibility; EventPricing get pricing; EventDetails get details;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.societyId, societyId) || other.societyId == societyId)&&(identical(other.societyName, societyName) || other.societyName == societyName)&&(identical(other.societyLogo, societyLogo) || other.societyLogo == societyLogo)&&(identical(other.title, title) || other.title == title)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.pricing, pricing) || other.pricing == pricing)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,societyId,societyName,societyLogo,title,visibility,pricing,details);

@override
String toString() {
  return 'Event(eventId: $eventId, societyId: $societyId, societyName: $societyName, societyLogo: $societyLogo, title: $title, visibility: $visibility, pricing: $pricing, details: $details)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'society_id') String societyId,@JsonKey(name: 'society_name') String societyName,@JsonKey(name: 'society_logo') String societyLogo, String title, String visibility, EventPricing pricing, EventDetails details
});


$EventPricingCopyWith<$Res> get pricing;$EventDetailsCopyWith<$Res> get details;

}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? societyId = null,Object? societyName = null,Object? societyLogo = null,Object? title = null,Object? visibility = null,Object? pricing = null,Object? details = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,societyId: null == societyId ? _self.societyId : societyId // ignore: cast_nullable_to_non_nullable
as String,societyName: null == societyName ? _self.societyName : societyName // ignore: cast_nullable_to_non_nullable
as String,societyLogo: null == societyLogo ? _self.societyLogo : societyLogo // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,pricing: null == pricing ? _self.pricing : pricing // ignore: cast_nullable_to_non_nullable
as EventPricing,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as EventDetails,
  ));
}
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventPricingCopyWith<$Res> get pricing {
  
  return $EventPricingCopyWith<$Res>(_self.pricing, (value) {
    return _then(_self.copyWith(pricing: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventDetailsCopyWith<$Res> get details {
  
  return $EventDetailsCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}
}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Event value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Event value)  $default,){
final _that = this;
switch (_that) {
case _Event():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Event value)?  $default,){
final _that = this;
switch (_that) {
case _Event() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'society_id')  String societyId, @JsonKey(name: 'society_name')  String societyName, @JsonKey(name: 'society_logo')  String societyLogo,  String title,  String visibility,  EventPricing pricing,  EventDetails details)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.eventId,_that.societyId,_that.societyName,_that.societyLogo,_that.title,_that.visibility,_that.pricing,_that.details);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'society_id')  String societyId, @JsonKey(name: 'society_name')  String societyName, @JsonKey(name: 'society_logo')  String societyLogo,  String title,  String visibility,  EventPricing pricing,  EventDetails details)  $default,) {final _that = this;
switch (_that) {
case _Event():
return $default(_that.eventId,_that.societyId,_that.societyName,_that.societyLogo,_that.title,_that.visibility,_that.pricing,_that.details);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'event_id')  String eventId, @JsonKey(name: 'society_id')  String societyId, @JsonKey(name: 'society_name')  String societyName, @JsonKey(name: 'society_logo')  String societyLogo,  String title,  String visibility,  EventPricing pricing,  EventDetails details)?  $default,) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.eventId,_that.societyId,_that.societyName,_that.societyLogo,_that.title,_that.visibility,_that.pricing,_that.details);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Event implements Event {
  const _Event({@JsonKey(name: 'event_id') required this.eventId, @JsonKey(name: 'society_id') required this.societyId, @JsonKey(name: 'society_name') this.societyName = 'Unknown Society', @JsonKey(name: 'society_logo') this.societyLogo = '', required this.title, required this.visibility, required this.pricing, required this.details});
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

@override@JsonKey(name: 'event_id') final  String eventId;
@override@JsonKey(name: 'society_id') final  String societyId;
@override@JsonKey(name: 'society_name') final  String societyName;
@override@JsonKey(name: 'society_logo') final  String societyLogo;
@override final  String title;
@override final  String visibility;
@override final  EventPricing pricing;
@override final  EventDetails details;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.societyId, societyId) || other.societyId == societyId)&&(identical(other.societyName, societyName) || other.societyName == societyName)&&(identical(other.societyLogo, societyLogo) || other.societyLogo == societyLogo)&&(identical(other.title, title) || other.title == title)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.pricing, pricing) || other.pricing == pricing)&&(identical(other.details, details) || other.details == details));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,societyId,societyName,societyLogo,title,visibility,pricing,details);

@override
String toString() {
  return 'Event(eventId: $eventId, societyId: $societyId, societyName: $societyName, societyLogo: $societyLogo, title: $title, visibility: $visibility, pricing: $pricing, details: $details)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'event_id') String eventId,@JsonKey(name: 'society_id') String societyId,@JsonKey(name: 'society_name') String societyName,@JsonKey(name: 'society_logo') String societyLogo, String title, String visibility, EventPricing pricing, EventDetails details
});


@override $EventPricingCopyWith<$Res> get pricing;@override $EventDetailsCopyWith<$Res> get details;

}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? societyId = null,Object? societyName = null,Object? societyLogo = null,Object? title = null,Object? visibility = null,Object? pricing = null,Object? details = null,}) {
  return _then(_Event(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,societyId: null == societyId ? _self.societyId : societyId // ignore: cast_nullable_to_non_nullable
as String,societyName: null == societyName ? _self.societyName : societyName // ignore: cast_nullable_to_non_nullable
as String,societyLogo: null == societyLogo ? _self.societyLogo : societyLogo // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,pricing: null == pricing ? _self.pricing : pricing // ignore: cast_nullable_to_non_nullable
as EventPricing,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as EventDetails,
  ));
}

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventPricingCopyWith<$Res> get pricing {
  
  return $EventPricingCopyWith<$Res>(_self.pricing, (value) {
    return _then(_self.copyWith(pricing: value));
  });
}/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventDetailsCopyWith<$Res> get details {
  
  return $EventDetailsCopyWith<$Res>(_self.details, (value) {
    return _then(_self.copyWith(details: value));
  });
}
}

// dart format on
