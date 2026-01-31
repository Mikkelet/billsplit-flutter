// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/update_phone_number/bloc/update_phone_number_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdatePhoneNumberState {

 bool get isLoading; String get errorMessage; String get phoneNumber; String get countryCode;
/// Create a copy of UpdatePhoneNumberState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdatePhoneNumberStateCopyWith<UpdatePhoneNumberState> get copyWith => _$UpdatePhoneNumberStateCopyWithImpl<UpdatePhoneNumberState>(this as UpdatePhoneNumberState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdatePhoneNumberState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,errorMessage,phoneNumber,countryCode);

@override
String toString() {
  return 'UpdatePhoneNumberState(isLoading: $isLoading, errorMessage: $errorMessage, phoneNumber: $phoneNumber, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class $UpdatePhoneNumberStateCopyWith<$Res>  {
  factory $UpdatePhoneNumberStateCopyWith(UpdatePhoneNumberState value, $Res Function(UpdatePhoneNumberState) _then) = _$UpdatePhoneNumberStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String errorMessage, String phoneNumber, String countryCode
});




}
/// @nodoc
class _$UpdatePhoneNumberStateCopyWithImpl<$Res>
    implements $UpdatePhoneNumberStateCopyWith<$Res> {
  _$UpdatePhoneNumberStateCopyWithImpl(this._self, this._then);

  final UpdatePhoneNumberState _self;
  final $Res Function(UpdatePhoneNumberState) _then;

/// Create a copy of UpdatePhoneNumberState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? errorMessage = null,Object? phoneNumber = null,Object? countryCode = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdatePhoneNumberState].
extension UpdatePhoneNumberStatePatterns on UpdatePhoneNumberState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdatePhoneNumberState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdatePhoneNumberState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdatePhoneNumberState value)  $default,){
final _that = this;
switch (_that) {
case _UpdatePhoneNumberState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdatePhoneNumberState value)?  $default,){
final _that = this;
switch (_that) {
case _UpdatePhoneNumberState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String errorMessage,  String phoneNumber,  String countryCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdatePhoneNumberState() when $default != null:
return $default(_that.isLoading,_that.errorMessage,_that.phoneNumber,_that.countryCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String errorMessage,  String phoneNumber,  String countryCode)  $default,) {final _that = this;
switch (_that) {
case _UpdatePhoneNumberState():
return $default(_that.isLoading,_that.errorMessage,_that.phoneNumber,_that.countryCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String errorMessage,  String phoneNumber,  String countryCode)?  $default,) {final _that = this;
switch (_that) {
case _UpdatePhoneNumberState() when $default != null:
return $default(_that.isLoading,_that.errorMessage,_that.phoneNumber,_that.countryCode);case _:
  return null;

}
}

}

/// @nodoc


class _UpdatePhoneNumberState implements UpdatePhoneNumberState {
  const _UpdatePhoneNumberState({this.isLoading = false, this.errorMessage = "", this.phoneNumber = "", this.countryCode = ""});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String errorMessage;
@override@JsonKey() final  String phoneNumber;
@override@JsonKey() final  String countryCode;

/// Create a copy of UpdatePhoneNumberState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatePhoneNumberStateCopyWith<_UpdatePhoneNumberState> get copyWith => __$UpdatePhoneNumberStateCopyWithImpl<_UpdatePhoneNumberState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatePhoneNumberState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,errorMessage,phoneNumber,countryCode);

@override
String toString() {
  return 'UpdatePhoneNumberState(isLoading: $isLoading, errorMessage: $errorMessage, phoneNumber: $phoneNumber, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class _$UpdatePhoneNumberStateCopyWith<$Res> implements $UpdatePhoneNumberStateCopyWith<$Res> {
  factory _$UpdatePhoneNumberStateCopyWith(_UpdatePhoneNumberState value, $Res Function(_UpdatePhoneNumberState) _then) = __$UpdatePhoneNumberStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String errorMessage, String phoneNumber, String countryCode
});




}
/// @nodoc
class __$UpdatePhoneNumberStateCopyWithImpl<$Res>
    implements _$UpdatePhoneNumberStateCopyWith<$Res> {
  __$UpdatePhoneNumberStateCopyWithImpl(this._self, this._then);

  final _UpdatePhoneNumberState _self;
  final $Res Function(_UpdatePhoneNumberState) _then;

/// Create a copy of UpdatePhoneNumberState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? errorMessage = null,Object? phoneNumber = null,Object? countryCode = null,}) {
  return _then(_UpdatePhoneNumberState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
