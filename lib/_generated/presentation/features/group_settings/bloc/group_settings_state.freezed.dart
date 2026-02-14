// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/group_settings/bloc/group_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupSettingsState {

 bool get leavingGroupIsLoading; bool get updatingCurrencyIsLoading; bool get addingToGroupIsLoading; bool get pictureUploadIsLoading; bool get updatingNameIsLoading; SplitsbyError get error; EditGroupNameState get displayState;
/// Create a copy of GroupSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupSettingsStateCopyWith<GroupSettingsState> get copyWith => _$GroupSettingsStateCopyWithImpl<GroupSettingsState>(this as GroupSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupSettingsState&&(identical(other.leavingGroupIsLoading, leavingGroupIsLoading) || other.leavingGroupIsLoading == leavingGroupIsLoading)&&(identical(other.updatingCurrencyIsLoading, updatingCurrencyIsLoading) || other.updatingCurrencyIsLoading == updatingCurrencyIsLoading)&&(identical(other.addingToGroupIsLoading, addingToGroupIsLoading) || other.addingToGroupIsLoading == addingToGroupIsLoading)&&(identical(other.pictureUploadIsLoading, pictureUploadIsLoading) || other.pictureUploadIsLoading == pictureUploadIsLoading)&&(identical(other.updatingNameIsLoading, updatingNameIsLoading) || other.updatingNameIsLoading == updatingNameIsLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.displayState, displayState) || other.displayState == displayState));
}


@override
int get hashCode => Object.hash(runtimeType,leavingGroupIsLoading,updatingCurrencyIsLoading,addingToGroupIsLoading,pictureUploadIsLoading,updatingNameIsLoading,error,displayState);

@override
String toString() {
  return 'GroupSettingsState(leavingGroupIsLoading: $leavingGroupIsLoading, updatingCurrencyIsLoading: $updatingCurrencyIsLoading, addingToGroupIsLoading: $addingToGroupIsLoading, pictureUploadIsLoading: $pictureUploadIsLoading, updatingNameIsLoading: $updatingNameIsLoading, error: $error, displayState: $displayState)';
}


}

/// @nodoc
abstract mixin class $GroupSettingsStateCopyWith<$Res>  {
  factory $GroupSettingsStateCopyWith(GroupSettingsState value, $Res Function(GroupSettingsState) _then) = _$GroupSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool leavingGroupIsLoading, bool updatingCurrencyIsLoading, bool addingToGroupIsLoading, bool pictureUploadIsLoading, bool updatingNameIsLoading, SplitsbyError error, EditGroupNameState displayState
});




}
/// @nodoc
class _$GroupSettingsStateCopyWithImpl<$Res>
    implements $GroupSettingsStateCopyWith<$Res> {
  _$GroupSettingsStateCopyWithImpl(this._self, this._then);

  final GroupSettingsState _self;
  final $Res Function(GroupSettingsState) _then;

/// Create a copy of GroupSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leavingGroupIsLoading = null,Object? updatingCurrencyIsLoading = null,Object? addingToGroupIsLoading = null,Object? pictureUploadIsLoading = null,Object? updatingNameIsLoading = null,Object? error = null,Object? displayState = null,}) {
  return _then(_self.copyWith(
leavingGroupIsLoading: null == leavingGroupIsLoading ? _self.leavingGroupIsLoading : leavingGroupIsLoading // ignore: cast_nullable_to_non_nullable
as bool,updatingCurrencyIsLoading: null == updatingCurrencyIsLoading ? _self.updatingCurrencyIsLoading : updatingCurrencyIsLoading // ignore: cast_nullable_to_non_nullable
as bool,addingToGroupIsLoading: null == addingToGroupIsLoading ? _self.addingToGroupIsLoading : addingToGroupIsLoading // ignore: cast_nullable_to_non_nullable
as bool,pictureUploadIsLoading: null == pictureUploadIsLoading ? _self.pictureUploadIsLoading : pictureUploadIsLoading // ignore: cast_nullable_to_non_nullable
as bool,updatingNameIsLoading: null == updatingNameIsLoading ? _self.updatingNameIsLoading : updatingNameIsLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,displayState: null == displayState ? _self.displayState : displayState // ignore: cast_nullable_to_non_nullable
as EditGroupNameState,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupSettingsState].
extension GroupSettingsStatePatterns on GroupSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _GroupSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _GroupSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool leavingGroupIsLoading,  bool updatingCurrencyIsLoading,  bool addingToGroupIsLoading,  bool pictureUploadIsLoading,  bool updatingNameIsLoading,  SplitsbyError error,  EditGroupNameState displayState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupSettingsState() when $default != null:
return $default(_that.leavingGroupIsLoading,_that.updatingCurrencyIsLoading,_that.addingToGroupIsLoading,_that.pictureUploadIsLoading,_that.updatingNameIsLoading,_that.error,_that.displayState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool leavingGroupIsLoading,  bool updatingCurrencyIsLoading,  bool addingToGroupIsLoading,  bool pictureUploadIsLoading,  bool updatingNameIsLoading,  SplitsbyError error,  EditGroupNameState displayState)  $default,) {final _that = this;
switch (_that) {
case _GroupSettingsState():
return $default(_that.leavingGroupIsLoading,_that.updatingCurrencyIsLoading,_that.addingToGroupIsLoading,_that.pictureUploadIsLoading,_that.updatingNameIsLoading,_that.error,_that.displayState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool leavingGroupIsLoading,  bool updatingCurrencyIsLoading,  bool addingToGroupIsLoading,  bool pictureUploadIsLoading,  bool updatingNameIsLoading,  SplitsbyError error,  EditGroupNameState displayState)?  $default,) {final _that = this;
switch (_that) {
case _GroupSettingsState() when $default != null:
return $default(_that.leavingGroupIsLoading,_that.updatingCurrencyIsLoading,_that.addingToGroupIsLoading,_that.pictureUploadIsLoading,_that.updatingNameIsLoading,_that.error,_that.displayState);case _:
  return null;

}
}

}

/// @nodoc


class _GroupSettingsState implements GroupSettingsState {
  const _GroupSettingsState({this.leavingGroupIsLoading = false, this.updatingCurrencyIsLoading = false, this.addingToGroupIsLoading = false, this.pictureUploadIsLoading = false, this.updatingNameIsLoading = false, this.error = const SplitsbyError.none(), this.displayState = EditGroupNameState.display});
  

@override@JsonKey() final  bool leavingGroupIsLoading;
@override@JsonKey() final  bool updatingCurrencyIsLoading;
@override@JsonKey() final  bool addingToGroupIsLoading;
@override@JsonKey() final  bool pictureUploadIsLoading;
@override@JsonKey() final  bool updatingNameIsLoading;
@override@JsonKey() final  SplitsbyError error;
@override@JsonKey() final  EditGroupNameState displayState;

/// Create a copy of GroupSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupSettingsStateCopyWith<_GroupSettingsState> get copyWith => __$GroupSettingsStateCopyWithImpl<_GroupSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupSettingsState&&(identical(other.leavingGroupIsLoading, leavingGroupIsLoading) || other.leavingGroupIsLoading == leavingGroupIsLoading)&&(identical(other.updatingCurrencyIsLoading, updatingCurrencyIsLoading) || other.updatingCurrencyIsLoading == updatingCurrencyIsLoading)&&(identical(other.addingToGroupIsLoading, addingToGroupIsLoading) || other.addingToGroupIsLoading == addingToGroupIsLoading)&&(identical(other.pictureUploadIsLoading, pictureUploadIsLoading) || other.pictureUploadIsLoading == pictureUploadIsLoading)&&(identical(other.updatingNameIsLoading, updatingNameIsLoading) || other.updatingNameIsLoading == updatingNameIsLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.displayState, displayState) || other.displayState == displayState));
}


@override
int get hashCode => Object.hash(runtimeType,leavingGroupIsLoading,updatingCurrencyIsLoading,addingToGroupIsLoading,pictureUploadIsLoading,updatingNameIsLoading,error,displayState);

@override
String toString() {
  return 'GroupSettingsState(leavingGroupIsLoading: $leavingGroupIsLoading, updatingCurrencyIsLoading: $updatingCurrencyIsLoading, addingToGroupIsLoading: $addingToGroupIsLoading, pictureUploadIsLoading: $pictureUploadIsLoading, updatingNameIsLoading: $updatingNameIsLoading, error: $error, displayState: $displayState)';
}


}

/// @nodoc
abstract mixin class _$GroupSettingsStateCopyWith<$Res> implements $GroupSettingsStateCopyWith<$Res> {
  factory _$GroupSettingsStateCopyWith(_GroupSettingsState value, $Res Function(_GroupSettingsState) _then) = __$GroupSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool leavingGroupIsLoading, bool updatingCurrencyIsLoading, bool addingToGroupIsLoading, bool pictureUploadIsLoading, bool updatingNameIsLoading, SplitsbyError error, EditGroupNameState displayState
});




}
/// @nodoc
class __$GroupSettingsStateCopyWithImpl<$Res>
    implements _$GroupSettingsStateCopyWith<$Res> {
  __$GroupSettingsStateCopyWithImpl(this._self, this._then);

  final _GroupSettingsState _self;
  final $Res Function(_GroupSettingsState) _then;

/// Create a copy of GroupSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leavingGroupIsLoading = null,Object? updatingCurrencyIsLoading = null,Object? addingToGroupIsLoading = null,Object? pictureUploadIsLoading = null,Object? updatingNameIsLoading = null,Object? error = null,Object? displayState = null,}) {
  return _then(_GroupSettingsState(
leavingGroupIsLoading: null == leavingGroupIsLoading ? _self.leavingGroupIsLoading : leavingGroupIsLoading // ignore: cast_nullable_to_non_nullable
as bool,updatingCurrencyIsLoading: null == updatingCurrencyIsLoading ? _self.updatingCurrencyIsLoading : updatingCurrencyIsLoading // ignore: cast_nullable_to_non_nullable
as bool,addingToGroupIsLoading: null == addingToGroupIsLoading ? _self.addingToGroupIsLoading : addingToGroupIsLoading // ignore: cast_nullable_to_non_nullable
as bool,pictureUploadIsLoading: null == pictureUploadIsLoading ? _self.pictureUploadIsLoading : pictureUploadIsLoading // ignore: cast_nullable_to_non_nullable
as bool,updatingNameIsLoading: null == updatingNameIsLoading ? _self.updatingNameIsLoading : updatingNameIsLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,displayState: null == displayState ? _self.displayState : displayState // ignore: cast_nullable_to_non_nullable
as EditGroupNameState,
  ));
}


}

// dart format on
