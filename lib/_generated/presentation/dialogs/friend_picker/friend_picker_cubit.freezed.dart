// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../presentation/dialogs/friend_picker/friend_picker_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FriendsPickerState {

 bool get isLoading; SplitsbyError get error;
/// Create a copy of FriendsPickerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendsPickerStateCopyWith<FriendsPickerState> get copyWith => _$FriendsPickerStateCopyWithImpl<FriendsPickerState>(this as FriendsPickerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendsPickerState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error);

@override
String toString() {
  return 'FriendsPickerState(isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $FriendsPickerStateCopyWith<$Res>  {
  factory $FriendsPickerStateCopyWith(FriendsPickerState value, $Res Function(FriendsPickerState) _then) = _$FriendsPickerStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SplitsbyError error
});




}
/// @nodoc
class _$FriendsPickerStateCopyWithImpl<$Res>
    implements $FriendsPickerStateCopyWith<$Res> {
  _$FriendsPickerStateCopyWithImpl(this._self, this._then);

  final FriendsPickerState _self;
  final $Res Function(FriendsPickerState) _then;

/// Create a copy of FriendsPickerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendsPickerState].
extension FriendsPickerStatePatterns on FriendsPickerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendsPickerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendsPickerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendsPickerState value)  $default,){
final _that = this;
switch (_that) {
case _FriendsPickerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendsPickerState value)?  $default,){
final _that = this;
switch (_that) {
case _FriendsPickerState() when $default != null:
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
case _FriendsPickerState() when $default != null:
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
case _FriendsPickerState():
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
case _FriendsPickerState() when $default != null:
return $default(_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _FriendsPickerState implements FriendsPickerState {
  const _FriendsPickerState({this.isLoading = false, this.error = const SplitsbyError.none()});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SplitsbyError error;

/// Create a copy of FriendsPickerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendsPickerStateCopyWith<_FriendsPickerState> get copyWith => __$FriendsPickerStateCopyWithImpl<_FriendsPickerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendsPickerState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error);

@override
String toString() {
  return 'FriendsPickerState(isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$FriendsPickerStateCopyWith<$Res> implements $FriendsPickerStateCopyWith<$Res> {
  factory _$FriendsPickerStateCopyWith(_FriendsPickerState value, $Res Function(_FriendsPickerState) _then) = __$FriendsPickerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SplitsbyError error
});




}
/// @nodoc
class __$FriendsPickerStateCopyWithImpl<$Res>
    implements _$FriendsPickerStateCopyWith<$Res> {
  __$FriendsPickerStateCopyWithImpl(this._self, this._then);

  final _FriendsPickerState _self;
  final $Res Function(_FriendsPickerState) _then;

/// Create a copy of FriendsPickerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,}) {
  return _then(_FriendsPickerState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,
  ));
}


}

// dart format on
