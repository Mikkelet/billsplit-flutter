// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/inspect_profile/bloc/inspect_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InspectProfileState {

 bool get isLoading; SplitsbyError get error; FriendStatus get status; List<Group> get groupsInCommon;
/// Create a copy of InspectProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InspectProfileStateCopyWith<InspectProfileState> get copyWith => _$InspectProfileStateCopyWithImpl<InspectProfileState>(this as InspectProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InspectProfileState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.groupsInCommon, groupsInCommon));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,status,const DeepCollectionEquality().hash(groupsInCommon));

@override
String toString() {
  return 'InspectProfileState(isLoading: $isLoading, error: $error, status: $status, groupsInCommon: $groupsInCommon)';
}


}

/// @nodoc
abstract mixin class $InspectProfileStateCopyWith<$Res>  {
  factory $InspectProfileStateCopyWith(InspectProfileState value, $Res Function(InspectProfileState) _then) = _$InspectProfileStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SplitsbyError error, FriendStatus status, List<Group> groupsInCommon
});




}
/// @nodoc
class _$InspectProfileStateCopyWithImpl<$Res>
    implements $InspectProfileStateCopyWith<$Res> {
  _$InspectProfileStateCopyWithImpl(this._self, this._then);

  final InspectProfileState _self;
  final $Res Function(InspectProfileState) _then;

/// Create a copy of InspectProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,Object? status = null,Object? groupsInCommon = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendStatus,groupsInCommon: null == groupsInCommon ? _self.groupsInCommon : groupsInCommon // ignore: cast_nullable_to_non_nullable
as List<Group>,
  ));
}

}


/// Adds pattern-matching-related methods to [InspectProfileState].
extension InspectProfileStatePatterns on InspectProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InspectProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InspectProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InspectProfileState value)  $default,){
final _that = this;
switch (_that) {
case _InspectProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InspectProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _InspectProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  FriendStatus status,  List<Group> groupsInCommon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InspectProfileState() when $default != null:
return $default(_that.isLoading,_that.error,_that.status,_that.groupsInCommon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  FriendStatus status,  List<Group> groupsInCommon)  $default,) {final _that = this;
switch (_that) {
case _InspectProfileState():
return $default(_that.isLoading,_that.error,_that.status,_that.groupsInCommon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  SplitsbyError error,  FriendStatus status,  List<Group> groupsInCommon)?  $default,) {final _that = this;
switch (_that) {
case _InspectProfileState() when $default != null:
return $default(_that.isLoading,_that.error,_that.status,_that.groupsInCommon);case _:
  return null;

}
}

}

/// @nodoc


class _InspectProfileState implements InspectProfileState {
  const _InspectProfileState({this.isLoading = false, this.error = const SplitsbyError.none(), this.status = FriendStatus.notFriends, final  List<Group> groupsInCommon = const []}): _groupsInCommon = groupsInCommon;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SplitsbyError error;
@override@JsonKey() final  FriendStatus status;
 final  List<Group> _groupsInCommon;
@override@JsonKey() List<Group> get groupsInCommon {
  if (_groupsInCommon is EqualUnmodifiableListView) return _groupsInCommon;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groupsInCommon);
}


/// Create a copy of InspectProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InspectProfileStateCopyWith<_InspectProfileState> get copyWith => __$InspectProfileStateCopyWithImpl<_InspectProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InspectProfileState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._groupsInCommon, _groupsInCommon));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,status,const DeepCollectionEquality().hash(_groupsInCommon));

@override
String toString() {
  return 'InspectProfileState(isLoading: $isLoading, error: $error, status: $status, groupsInCommon: $groupsInCommon)';
}


}

/// @nodoc
abstract mixin class _$InspectProfileStateCopyWith<$Res> implements $InspectProfileStateCopyWith<$Res> {
  factory _$InspectProfileStateCopyWith(_InspectProfileState value, $Res Function(_InspectProfileState) _then) = __$InspectProfileStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SplitsbyError error, FriendStatus status, List<Group> groupsInCommon
});




}
/// @nodoc
class __$InspectProfileStateCopyWithImpl<$Res>
    implements _$InspectProfileStateCopyWith<$Res> {
  __$InspectProfileStateCopyWithImpl(this._self, this._then);

  final _InspectProfileState _self;
  final $Res Function(_InspectProfileState) _then;

/// Create a copy of InspectProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,Object? status = null,Object? groupsInCommon = null,}) {
  return _then(_InspectProfileState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendStatus,groupsInCommon: null == groupsInCommon ? _self._groupsInCommon : groupsInCommon // ignore: cast_nullable_to_non_nullable
as List<Group>,
  ));
}


}

// dart format on
