// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/group/bloc/group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupState {

 bool get isLoading; GroupPageNav get groupNav; SortEvents get sortBy; Iterable<Pair<Person, num>> get debts; SplitsbyError get error; Group? get group;
/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupStateCopyWith<GroupState> get copyWith => _$GroupStateCopyWithImpl<GroupState>(this as GroupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.groupNav, groupNav) || other.groupNav == groupNav)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&const DeepCollectionEquality().equals(other.debts, debts)&&(identical(other.error, error) || other.error == error)&&(identical(other.group, group) || other.group == group));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,groupNav,sortBy,const DeepCollectionEquality().hash(debts),error,group);

@override
String toString() {
  return 'GroupState(isLoading: $isLoading, groupNav: $groupNav, sortBy: $sortBy, debts: $debts, error: $error, group: $group)';
}


}

/// @nodoc
abstract mixin class $GroupStateCopyWith<$Res>  {
  factory $GroupStateCopyWith(GroupState value, $Res Function(GroupState) _then) = _$GroupStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, GroupPageNav groupNav, SortEvents sortBy, Iterable<Pair<Person, num>> debts, SplitsbyError error, Group? group
});


$GroupCopyWith<$Res>? get group;

}
/// @nodoc
class _$GroupStateCopyWithImpl<$Res>
    implements $GroupStateCopyWith<$Res> {
  _$GroupStateCopyWithImpl(this._self, this._then);

  final GroupState _self;
  final $Res Function(GroupState) _then;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? groupNav = null,Object? sortBy = null,Object? debts = null,Object? error = null,Object? group = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,groupNav: null == groupNav ? _self.groupNav : groupNav // ignore: cast_nullable_to_non_nullable
as GroupPageNav,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortEvents,debts: null == debts ? _self.debts : debts // ignore: cast_nullable_to_non_nullable
as Iterable<Pair<Person, num>>,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as Group?,
  ));
}
/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res>? get group {
    if (_self.group == null) {
    return null;
  }

  return $GroupCopyWith<$Res>(_self.group!, (value) {
    return _then(_self.copyWith(group: value));
  });
}
}


/// Adds pattern-matching-related methods to [GroupState].
extension GroupStatePatterns on GroupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupState value)  $default,){
final _that = this;
switch (_that) {
case _GroupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupState value)?  $default,){
final _that = this;
switch (_that) {
case _GroupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  GroupPageNav groupNav,  SortEvents sortBy,  Iterable<Pair<Person, num>> debts,  SplitsbyError error,  Group? group)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupState() when $default != null:
return $default(_that.isLoading,_that.groupNav,_that.sortBy,_that.debts,_that.error,_that.group);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  GroupPageNav groupNav,  SortEvents sortBy,  Iterable<Pair<Person, num>> debts,  SplitsbyError error,  Group? group)  $default,) {final _that = this;
switch (_that) {
case _GroupState():
return $default(_that.isLoading,_that.groupNav,_that.sortBy,_that.debts,_that.error,_that.group);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  GroupPageNav groupNav,  SortEvents sortBy,  Iterable<Pair<Person, num>> debts,  SplitsbyError error,  Group? group)?  $default,) {final _that = this;
switch (_that) {
case _GroupState() when $default != null:
return $default(_that.isLoading,_that.groupNav,_that.sortBy,_that.debts,_that.error,_that.group);case _:
  return null;

}
}

}

/// @nodoc


class _GroupState extends GroupState {
  const _GroupState({this.isLoading = false, this.groupNav = GroupPageNav.events, this.sortBy = SortEvents.added, this.debts = const [], this.error = const SplitsbyError.none(), this.group}): super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  GroupPageNav groupNav;
@override@JsonKey() final  SortEvents sortBy;
@override@JsonKey() final  Iterable<Pair<Person, num>> debts;
@override@JsonKey() final  SplitsbyError error;
@override final  Group? group;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupStateCopyWith<_GroupState> get copyWith => __$GroupStateCopyWithImpl<_GroupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.groupNav, groupNav) || other.groupNav == groupNav)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&const DeepCollectionEquality().equals(other.debts, debts)&&(identical(other.error, error) || other.error == error)&&(identical(other.group, group) || other.group == group));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,groupNav,sortBy,const DeepCollectionEquality().hash(debts),error,group);

@override
String toString() {
  return 'GroupState(isLoading: $isLoading, groupNav: $groupNav, sortBy: $sortBy, debts: $debts, error: $error, group: $group)';
}


}

/// @nodoc
abstract mixin class _$GroupStateCopyWith<$Res> implements $GroupStateCopyWith<$Res> {
  factory _$GroupStateCopyWith(_GroupState value, $Res Function(_GroupState) _then) = __$GroupStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, GroupPageNav groupNav, SortEvents sortBy, Iterable<Pair<Person, num>> debts, SplitsbyError error, Group? group
});


@override $GroupCopyWith<$Res>? get group;

}
/// @nodoc
class __$GroupStateCopyWithImpl<$Res>
    implements _$GroupStateCopyWith<$Res> {
  __$GroupStateCopyWithImpl(this._self, this._then);

  final _GroupState _self;
  final $Res Function(_GroupState) _then;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? groupNav = null,Object? sortBy = null,Object? debts = null,Object? error = null,Object? group = freezed,}) {
  return _then(_GroupState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,groupNav: null == groupNav ? _self.groupNav : groupNav // ignore: cast_nullable_to_non_nullable
as GroupPageNav,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortEvents,debts: null == debts ? _self.debts : debts // ignore: cast_nullable_to_non_nullable
as Iterable<Pair<Person, num>>,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as Group?,
  ));
}

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res>? get group {
    if (_self.group == null) {
    return null;
  }

  return $GroupCopyWith<$Res>(_self.group!, (value) {
    return _then(_self.copyWith(group: value));
  });
}
}

// dart format on
