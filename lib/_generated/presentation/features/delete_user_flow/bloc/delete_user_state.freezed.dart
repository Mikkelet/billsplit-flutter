// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/delete_user_flow/bloc/delete_user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeleteUserState {

 bool get isLoading; SplitsbyError get error;
/// Create a copy of DeleteUserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteUserStateCopyWith<DeleteUserState> get copyWith => _$DeleteUserStateCopyWithImpl<DeleteUserState>(this as DeleteUserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteUserState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error);

@override
String toString() {
  return 'DeleteUserState(isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $DeleteUserStateCopyWith<$Res>  {
  factory $DeleteUserStateCopyWith(DeleteUserState value, $Res Function(DeleteUserState) _then) = _$DeleteUserStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SplitsbyError error
});




}
/// @nodoc
class _$DeleteUserStateCopyWithImpl<$Res>
    implements $DeleteUserStateCopyWith<$Res> {
  _$DeleteUserStateCopyWithImpl(this._self, this._then);

  final DeleteUserState _self;
  final $Res Function(DeleteUserState) _then;

/// Create a copy of DeleteUserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,
  ));
}

}


/// Adds pattern-matching-related methods to [DeleteUserState].
extension DeleteUserStatePatterns on DeleteUserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeleteUserState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteUserState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeleteUserState value)  $default,){
final _that = this;
switch (_that) {
case _DeleteUserState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeleteUserState value)?  $default,){
final _that = this;
switch (_that) {
case _DeleteUserState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeleteUserState() when $default != null:
return $default(_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error)  $default,) {final _that = this;
switch (_that) {
case _DeleteUserState():
return $default(_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  SplitsbyError error)?  $default,) {final _that = this;
switch (_that) {
case _DeleteUserState() when $default != null:
return $default(_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _DeleteUserState implements DeleteUserState {
  const _DeleteUserState({this.isLoading = false, this.error = const SplitsbyError.none()});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SplitsbyError error;

/// Create a copy of DeleteUserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteUserStateCopyWith<_DeleteUserState> get copyWith => __$DeleteUserStateCopyWithImpl<_DeleteUserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteUserState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error);

@override
String toString() {
  return 'DeleteUserState(isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DeleteUserStateCopyWith<$Res> implements $DeleteUserStateCopyWith<$Res> {
  factory _$DeleteUserStateCopyWith(_DeleteUserState value, $Res Function(_DeleteUserState) _then) = __$DeleteUserStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SplitsbyError error
});




}
/// @nodoc
class __$DeleteUserStateCopyWithImpl<$Res>
    implements _$DeleteUserStateCopyWith<$Res> {
  __$DeleteUserStateCopyWithImpl(this._self, this._then);

  final _DeleteUserState _self;
  final $Res Function(_DeleteUserState) _then;

/// Create a copy of DeleteUserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,}) {
  return _then(_DeleteUserState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,
  ));
}


}

// dart format on
