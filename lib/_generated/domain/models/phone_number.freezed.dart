// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../domain/models/phone_number.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PhoneNumber {

 String get phoneNumber; String get countryCode;
/// Create a copy of PhoneNumber
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneNumberCopyWith<PhoneNumber> get copyWith => _$PhoneNumberCopyWithImpl<PhoneNumber>(this as PhoneNumber, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneNumber&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,countryCode);

@override
String toString() {
  return 'PhoneNumber(phoneNumber: $phoneNumber, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class $PhoneNumberCopyWith<$Res>  {
  factory $PhoneNumberCopyWith(PhoneNumber value, $Res Function(PhoneNumber) _then) = _$PhoneNumberCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String countryCode
});




}
/// @nodoc
class _$PhoneNumberCopyWithImpl<$Res>
    implements $PhoneNumberCopyWith<$Res> {
  _$PhoneNumberCopyWithImpl(this._self, this._then);

  final PhoneNumber _self;
  final $Res Function(PhoneNumber) _then;

/// Create a copy of PhoneNumber
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? countryCode = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneNumber].
extension PhoneNumberPatterns on PhoneNumber {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneNumber value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneNumber() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneNumber value)  $default,){
final _that = this;
switch (_that) {
case _PhoneNumber():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneNumber value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneNumber() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  String countryCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneNumber() when $default != null:
return $default(_that.phoneNumber,_that.countryCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  String countryCode)  $default,) {final _that = this;
switch (_that) {
case _PhoneNumber():
return $default(_that.phoneNumber,_that.countryCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  String countryCode)?  $default,) {final _that = this;
switch (_that) {
case _PhoneNumber() when $default != null:
return $default(_that.phoneNumber,_that.countryCode);case _:
  return null;

}
}

}

/// @nodoc


class _PhoneNumber extends PhoneNumber {
  const _PhoneNumber({this.phoneNumber = "", this.countryCode = ""}): super._();
  

@override@JsonKey() final  String phoneNumber;
@override@JsonKey() final  String countryCode;

/// Create a copy of PhoneNumber
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneNumberCopyWith<_PhoneNumber> get copyWith => __$PhoneNumberCopyWithImpl<_PhoneNumber>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneNumber&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,countryCode);

@override
String toString() {
  return 'PhoneNumber(phoneNumber: $phoneNumber, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class _$PhoneNumberCopyWith<$Res> implements $PhoneNumberCopyWith<$Res> {
  factory _$PhoneNumberCopyWith(_PhoneNumber value, $Res Function(_PhoneNumber) _then) = __$PhoneNumberCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String countryCode
});




}
/// @nodoc
class __$PhoneNumberCopyWithImpl<$Res>
    implements _$PhoneNumberCopyWith<$Res> {
  __$PhoneNumberCopyWithImpl(this._self, this._then);

  final _PhoneNumber _self;
  final $Res Function(_PhoneNumber) _then;

/// Create a copy of PhoneNumber
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? countryCode = null,}) {
  return _then(_PhoneNumber(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
