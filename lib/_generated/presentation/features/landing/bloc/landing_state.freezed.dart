// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/landing/bloc/landing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LandingState {

 bool get isLoading; SplitsbyError get error; String get emailError; String get passwordError; String get repeatPasswordError;
/// Create a copy of LandingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LandingStateCopyWith<LandingState> get copyWith => _$LandingStateCopyWithImpl<LandingState>(this as LandingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LandingState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.repeatPasswordError, repeatPasswordError) || other.repeatPasswordError == repeatPasswordError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,emailError,passwordError,repeatPasswordError);

@override
String toString() {
  return 'LandingState(isLoading: $isLoading, error: $error, emailError: $emailError, passwordError: $passwordError, repeatPasswordError: $repeatPasswordError)';
}


}

/// @nodoc
abstract mixin class $LandingStateCopyWith<$Res>  {
  factory $LandingStateCopyWith(LandingState value, $Res Function(LandingState) _then) = _$LandingStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SplitsbyError error, String emailError, String passwordError, String repeatPasswordError
});




}
/// @nodoc
class _$LandingStateCopyWithImpl<$Res>
    implements $LandingStateCopyWith<$Res> {
  _$LandingStateCopyWithImpl(this._self, this._then);

  final LandingState _self;
  final $Res Function(LandingState) _then;

/// Create a copy of LandingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,Object? emailError = null,Object? passwordError = null,Object? repeatPasswordError = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String,passwordError: null == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String,repeatPasswordError: null == repeatPasswordError ? _self.repeatPasswordError : repeatPasswordError // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LandingState].
extension LandingStatePatterns on LandingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LandingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LandingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LandingState value)  $default,){
final _that = this;
switch (_that) {
case _LandingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LandingState value)?  $default,){
final _that = this;
switch (_that) {
case _LandingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  String emailError,  String passwordError,  String repeatPasswordError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LandingState() when $default != null:
return $default(_that.isLoading,_that.error,_that.emailError,_that.passwordError,_that.repeatPasswordError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  String emailError,  String passwordError,  String repeatPasswordError)  $default,) {final _that = this;
switch (_that) {
case _LandingState():
return $default(_that.isLoading,_that.error,_that.emailError,_that.passwordError,_that.repeatPasswordError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  SplitsbyError error,  String emailError,  String passwordError,  String repeatPasswordError)?  $default,) {final _that = this;
switch (_that) {
case _LandingState() when $default != null:
return $default(_that.isLoading,_that.error,_that.emailError,_that.passwordError,_that.repeatPasswordError);case _:
  return null;

}
}

}

/// @nodoc


class _LandingState extends LandingState {
  const _LandingState({this.isLoading = false, this.error = const SplitsbyError.none(), this.emailError = "", this.passwordError = "", this.repeatPasswordError = ""}): super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SplitsbyError error;
@override@JsonKey() final  String emailError;
@override@JsonKey() final  String passwordError;
@override@JsonKey() final  String repeatPasswordError;

/// Create a copy of LandingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LandingStateCopyWith<_LandingState> get copyWith => __$LandingStateCopyWithImpl<_LandingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LandingState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.repeatPasswordError, repeatPasswordError) || other.repeatPasswordError == repeatPasswordError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,emailError,passwordError,repeatPasswordError);

@override
String toString() {
  return 'LandingState(isLoading: $isLoading, error: $error, emailError: $emailError, passwordError: $passwordError, repeatPasswordError: $repeatPasswordError)';
}


}

/// @nodoc
abstract mixin class _$LandingStateCopyWith<$Res> implements $LandingStateCopyWith<$Res> {
  factory _$LandingStateCopyWith(_LandingState value, $Res Function(_LandingState) _then) = __$LandingStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SplitsbyError error, String emailError, String passwordError, String repeatPasswordError
});




}
/// @nodoc
class __$LandingStateCopyWithImpl<$Res>
    implements _$LandingStateCopyWith<$Res> {
  __$LandingStateCopyWithImpl(this._self, this._then);

  final _LandingState _self;
  final $Res Function(_LandingState) _then;

/// Create a copy of LandingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,Object? emailError = null,Object? passwordError = null,Object? repeatPasswordError = null,}) {
  return _then(_LandingState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,emailError: null == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String,passwordError: null == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String,repeatPasswordError: null == repeatPasswordError ? _self.repeatPasswordError : repeatPasswordError // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
