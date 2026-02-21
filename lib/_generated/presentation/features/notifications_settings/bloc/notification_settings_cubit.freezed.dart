// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/notifications_settings/bloc/notification_settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsSettingsState {

 bool get isLoading; bool get isSubscribed; SplitsbyError get error;
/// Create a copy of NotificationsSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsSettingsStateCopyWith<NotificationsSettingsState> get copyWith => _$NotificationsSettingsStateCopyWithImpl<NotificationsSettingsState>(this as NotificationsSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsSettingsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSubscribed,error);

@override
String toString() {
  return 'NotificationsSettingsState(isLoading: $isLoading, isSubscribed: $isSubscribed, error: $error)';
}


}

/// @nodoc
abstract mixin class $NotificationsSettingsStateCopyWith<$Res>  {
  factory $NotificationsSettingsStateCopyWith(NotificationsSettingsState value, $Res Function(NotificationsSettingsState) _then) = _$NotificationsSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSubscribed, SplitsbyError error
});




}
/// @nodoc
class _$NotificationsSettingsStateCopyWithImpl<$Res>
    implements $NotificationsSettingsStateCopyWith<$Res> {
  _$NotificationsSettingsStateCopyWithImpl(this._self, this._then);

  final NotificationsSettingsState _self;
  final $Res Function(NotificationsSettingsState) _then;

/// Create a copy of NotificationsSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSubscribed = null,Object? error = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationsSettingsState].
extension NotificationsSettingsStatePatterns on NotificationsSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationsSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationsSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationsSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationsSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationsSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationsSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSubscribed,  SplitsbyError error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationsSettingsState() when $default != null:
return $default(_that.isLoading,_that.isSubscribed,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSubscribed,  SplitsbyError error)  $default,) {final _that = this;
switch (_that) {
case _NotificationsSettingsState():
return $default(_that.isLoading,_that.isSubscribed,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSubscribed,  SplitsbyError error)?  $default,) {final _that = this;
switch (_that) {
case _NotificationsSettingsState() when $default != null:
return $default(_that.isLoading,_that.isSubscribed,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationsSettingsState implements NotificationsSettingsState {
  const _NotificationsSettingsState({this.isLoading = false, this.isSubscribed = false, this.error = const SplitsbyError.none()});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSubscribed;
@override@JsonKey() final  SplitsbyError error;

/// Create a copy of NotificationsSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsSettingsStateCopyWith<_NotificationsSettingsState> get copyWith => __$NotificationsSettingsStateCopyWithImpl<_NotificationsSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsSettingsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSubscribed,error);

@override
String toString() {
  return 'NotificationsSettingsState(isLoading: $isLoading, isSubscribed: $isSubscribed, error: $error)';
}


}

/// @nodoc
abstract mixin class _$NotificationsSettingsStateCopyWith<$Res> implements $NotificationsSettingsStateCopyWith<$Res> {
  factory _$NotificationsSettingsStateCopyWith(_NotificationsSettingsState value, $Res Function(_NotificationsSettingsState) _then) = __$NotificationsSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSubscribed, SplitsbyError error
});




}
/// @nodoc
class __$NotificationsSettingsStateCopyWithImpl<$Res>
    implements _$NotificationsSettingsStateCopyWith<$Res> {
  __$NotificationsSettingsStateCopyWithImpl(this._self, this._then);

  final _NotificationsSettingsState _self;
  final $Res Function(_NotificationsSettingsState) _then;

/// Create a copy of NotificationsSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSubscribed = null,Object? error = null,}) {
  return _then(_NotificationsSettingsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,
  ));
}


}

// dart format on
