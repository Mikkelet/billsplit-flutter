// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/add_service/bloc/add_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddServiceState {

 bool get isLoading; SplitsbyError get error; bool get showCannotBe0ZeroError; String get nameErrorText;
/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddServiceStateCopyWith<AddServiceState> get copyWith => _$AddServiceStateCopyWithImpl<AddServiceState>(this as AddServiceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddServiceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.showCannotBe0ZeroError, showCannotBe0ZeroError) || other.showCannotBe0ZeroError == showCannotBe0ZeroError)&&(identical(other.nameErrorText, nameErrorText) || other.nameErrorText == nameErrorText));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,showCannotBe0ZeroError,nameErrorText);

@override
String toString() {
  return 'AddServiceState(isLoading: $isLoading, error: $error, showCannotBe0ZeroError: $showCannotBe0ZeroError, nameErrorText: $nameErrorText)';
}


}

/// @nodoc
abstract mixin class $AddServiceStateCopyWith<$Res>  {
  factory $AddServiceStateCopyWith(AddServiceState value, $Res Function(AddServiceState) _then) = _$AddServiceStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SplitsbyError error, bool showCannotBe0ZeroError, String nameErrorText
});




}
/// @nodoc
class _$AddServiceStateCopyWithImpl<$Res>
    implements $AddServiceStateCopyWith<$Res> {
  _$AddServiceStateCopyWithImpl(this._self, this._then);

  final AddServiceState _self;
  final $Res Function(AddServiceState) _then;

/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,Object? showCannotBe0ZeroError = null,Object? nameErrorText = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,showCannotBe0ZeroError: null == showCannotBe0ZeroError ? _self.showCannotBe0ZeroError : showCannotBe0ZeroError // ignore: cast_nullable_to_non_nullable
as bool,nameErrorText: null == nameErrorText ? _self.nameErrorText : nameErrorText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AddServiceState].
extension AddServiceStatePatterns on AddServiceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddServiceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddServiceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddServiceState value)  $default,){
final _that = this;
switch (_that) {
case _AddServiceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddServiceState value)?  $default,){
final _that = this;
switch (_that) {
case _AddServiceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  bool showCannotBe0ZeroError,  String nameErrorText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddServiceState() when $default != null:
return $default(_that.isLoading,_that.error,_that.showCannotBe0ZeroError,_that.nameErrorText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  bool showCannotBe0ZeroError,  String nameErrorText)  $default,) {final _that = this;
switch (_that) {
case _AddServiceState():
return $default(_that.isLoading,_that.error,_that.showCannotBe0ZeroError,_that.nameErrorText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  SplitsbyError error,  bool showCannotBe0ZeroError,  String nameErrorText)?  $default,) {final _that = this;
switch (_that) {
case _AddServiceState() when $default != null:
return $default(_that.isLoading,_that.error,_that.showCannotBe0ZeroError,_that.nameErrorText);case _:
  return null;

}
}

}

/// @nodoc


class _AddServiceState implements AddServiceState {
  const _AddServiceState({this.isLoading = false, this.error = const SplitsbyError.none(), this.showCannotBe0ZeroError = false, this.nameErrorText = ""});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SplitsbyError error;
@override@JsonKey() final  bool showCannotBe0ZeroError;
@override@JsonKey() final  String nameErrorText;

/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddServiceStateCopyWith<_AddServiceState> get copyWith => __$AddServiceStateCopyWithImpl<_AddServiceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddServiceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.showCannotBe0ZeroError, showCannotBe0ZeroError) || other.showCannotBe0ZeroError == showCannotBe0ZeroError)&&(identical(other.nameErrorText, nameErrorText) || other.nameErrorText == nameErrorText));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,showCannotBe0ZeroError,nameErrorText);

@override
String toString() {
  return 'AddServiceState(isLoading: $isLoading, error: $error, showCannotBe0ZeroError: $showCannotBe0ZeroError, nameErrorText: $nameErrorText)';
}


}

/// @nodoc
abstract mixin class _$AddServiceStateCopyWith<$Res> implements $AddServiceStateCopyWith<$Res> {
  factory _$AddServiceStateCopyWith(_AddServiceState value, $Res Function(_AddServiceState) _then) = __$AddServiceStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SplitsbyError error, bool showCannotBe0ZeroError, String nameErrorText
});




}
/// @nodoc
class __$AddServiceStateCopyWithImpl<$Res>
    implements _$AddServiceStateCopyWith<$Res> {
  __$AddServiceStateCopyWithImpl(this._self, this._then);

  final _AddServiceState _self;
  final $Res Function(_AddServiceState) _then;

/// Create a copy of AddServiceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,Object? showCannotBe0ZeroError = null,Object? nameErrorText = null,}) {
  return _then(_AddServiceState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,showCannotBe0ZeroError: null == showCannotBe0ZeroError ? _self.showCannotBe0ZeroError : showCannotBe0ZeroError // ignore: cast_nullable_to_non_nullable
as bool,nameErrorText: null == nameErrorText ? _self.nameErrorText : nameErrorText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
