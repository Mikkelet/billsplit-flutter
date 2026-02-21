// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../presentation/common/update_textfield/update_textfield_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdatableTextFieldState {

 bool get isLoading; SplitsbyError get error; UpdatableTextFieldView get view;
/// Create a copy of UpdatableTextFieldState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdatableTextFieldStateCopyWith<UpdatableTextFieldState> get copyWith => _$UpdatableTextFieldStateCopyWithImpl<UpdatableTextFieldState>(this as UpdatableTextFieldState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdatableTextFieldState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.view, view) || other.view == view));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,view);

@override
String toString() {
  return 'UpdatableTextFieldState(isLoading: $isLoading, error: $error, view: $view)';
}


}

/// @nodoc
abstract mixin class $UpdatableTextFieldStateCopyWith<$Res>  {
  factory $UpdatableTextFieldStateCopyWith(UpdatableTextFieldState value, $Res Function(UpdatableTextFieldState) _then) = _$UpdatableTextFieldStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SplitsbyError error, UpdatableTextFieldView view
});




}
/// @nodoc
class _$UpdatableTextFieldStateCopyWithImpl<$Res>
    implements $UpdatableTextFieldStateCopyWith<$Res> {
  _$UpdatableTextFieldStateCopyWithImpl(this._self, this._then);

  final UpdatableTextFieldState _self;
  final $Res Function(UpdatableTextFieldState) _then;

/// Create a copy of UpdatableTextFieldState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,Object? view = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as UpdatableTextFieldView,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdatableTextFieldState].
extension UpdatableTextFieldStatePatterns on UpdatableTextFieldState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdatableTextFieldState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdatableTextFieldState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdatableTextFieldState value)  $default,){
final _that = this;
switch (_that) {
case _UpdatableTextFieldState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdatableTextFieldState value)?  $default,){
final _that = this;
switch (_that) {
case _UpdatableTextFieldState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  UpdatableTextFieldView view)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdatableTextFieldState() when $default != null:
return $default(_that.isLoading,_that.error,_that.view);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  UpdatableTextFieldView view)  $default,) {final _that = this;
switch (_that) {
case _UpdatableTextFieldState():
return $default(_that.isLoading,_that.error,_that.view);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  SplitsbyError error,  UpdatableTextFieldView view)?  $default,) {final _that = this;
switch (_that) {
case _UpdatableTextFieldState() when $default != null:
return $default(_that.isLoading,_that.error,_that.view);case _:
  return null;

}
}

}

/// @nodoc


class _UpdatableTextFieldState implements UpdatableTextFieldState {
  const _UpdatableTextFieldState({this.isLoading = false, this.error = const SplitsbyError.none(), this.view = UpdatableTextFieldView.display});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SplitsbyError error;
@override@JsonKey() final  UpdatableTextFieldView view;

/// Create a copy of UpdatableTextFieldState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatableTextFieldStateCopyWith<_UpdatableTextFieldState> get copyWith => __$UpdatableTextFieldStateCopyWithImpl<_UpdatableTextFieldState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatableTextFieldState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.view, view) || other.view == view));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,view);

@override
String toString() {
  return 'UpdatableTextFieldState(isLoading: $isLoading, error: $error, view: $view)';
}


}

/// @nodoc
abstract mixin class _$UpdatableTextFieldStateCopyWith<$Res> implements $UpdatableTextFieldStateCopyWith<$Res> {
  factory _$UpdatableTextFieldStateCopyWith(_UpdatableTextFieldState value, $Res Function(_UpdatableTextFieldState) _then) = __$UpdatableTextFieldStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SplitsbyError error, UpdatableTextFieldView view
});




}
/// @nodoc
class __$UpdatableTextFieldStateCopyWithImpl<$Res>
    implements _$UpdatableTextFieldStateCopyWith<$Res> {
  __$UpdatableTextFieldStateCopyWithImpl(this._self, this._then);

  final _UpdatableTextFieldState _self;
  final $Res Function(_UpdatableTextFieldState) _then;

/// Create a copy of UpdatableTextFieldState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,Object? view = null,}) {
  return _then(_UpdatableTextFieldState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as UpdatableTextFieldView,
  ));
}


}

// dart format on
