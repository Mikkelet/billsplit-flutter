// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/add_group/bloc/add_group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddGroupState {

 bool get isLoading; SplitsbyError get error; String get groupName; String get currency; List<Person> get people; bool get isAdded;
/// Create a copy of AddGroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddGroupStateCopyWith<AddGroupState> get copyWith => _$AddGroupStateCopyWithImpl<AddGroupState>(this as AddGroupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddGroupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.people, people)&&(identical(other.isAdded, isAdded) || other.isAdded == isAdded));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,groupName,currency,const DeepCollectionEquality().hash(people),isAdded);

@override
String toString() {
  return 'AddGroupState(isLoading: $isLoading, error: $error, groupName: $groupName, currency: $currency, people: $people, isAdded: $isAdded)';
}


}

/// @nodoc
abstract mixin class $AddGroupStateCopyWith<$Res>  {
  factory $AddGroupStateCopyWith(AddGroupState value, $Res Function(AddGroupState) _then) = _$AddGroupStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SplitsbyError error, String groupName, String currency, List<Person> people, bool isAdded
});




}
/// @nodoc
class _$AddGroupStateCopyWithImpl<$Res>
    implements $AddGroupStateCopyWith<$Res> {
  _$AddGroupStateCopyWithImpl(this._self, this._then);

  final AddGroupState _self;
  final $Res Function(AddGroupState) _then;

/// Create a copy of AddGroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,Object? groupName = null,Object? currency = null,Object? people = null,Object? isAdded = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as List<Person>,isAdded: null == isAdded ? _self.isAdded : isAdded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AddGroupState].
extension AddGroupStatePatterns on AddGroupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddGroupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddGroupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddGroupState value)  $default,){
final _that = this;
switch (_that) {
case _AddGroupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddGroupState value)?  $default,){
final _that = this;
switch (_that) {
case _AddGroupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  String groupName,  String currency,  List<Person> people,  bool isAdded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddGroupState() when $default != null:
return $default(_that.isLoading,_that.error,_that.groupName,_that.currency,_that.people,_that.isAdded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  String groupName,  String currency,  List<Person> people,  bool isAdded)  $default,) {final _that = this;
switch (_that) {
case _AddGroupState():
return $default(_that.isLoading,_that.error,_that.groupName,_that.currency,_that.people,_that.isAdded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  SplitsbyError error,  String groupName,  String currency,  List<Person> people,  bool isAdded)?  $default,) {final _that = this;
switch (_that) {
case _AddGroupState() when $default != null:
return $default(_that.isLoading,_that.error,_that.groupName,_that.currency,_that.people,_that.isAdded);case _:
  return null;

}
}

}

/// @nodoc


class _AddGroupState implements AddGroupState {
  const _AddGroupState({this.isLoading = false, this.error = const SplitsbyError.none(), this.groupName = "", this.currency = "", final  List<Person> people = const [], this.isAdded = false}): _people = people;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SplitsbyError error;
@override@JsonKey() final  String groupName;
@override@JsonKey() final  String currency;
 final  List<Person> _people;
@override@JsonKey() List<Person> get people {
  if (_people is EqualUnmodifiableListView) return _people;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_people);
}

@override@JsonKey() final  bool isAdded;

/// Create a copy of AddGroupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddGroupStateCopyWith<_AddGroupState> get copyWith => __$AddGroupStateCopyWithImpl<_AddGroupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddGroupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._people, _people)&&(identical(other.isAdded, isAdded) || other.isAdded == isAdded));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,groupName,currency,const DeepCollectionEquality().hash(_people),isAdded);

@override
String toString() {
  return 'AddGroupState(isLoading: $isLoading, error: $error, groupName: $groupName, currency: $currency, people: $people, isAdded: $isAdded)';
}


}

/// @nodoc
abstract mixin class _$AddGroupStateCopyWith<$Res> implements $AddGroupStateCopyWith<$Res> {
  factory _$AddGroupStateCopyWith(_AddGroupState value, $Res Function(_AddGroupState) _then) = __$AddGroupStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SplitsbyError error, String groupName, String currency, List<Person> people, bool isAdded
});




}
/// @nodoc
class __$AddGroupStateCopyWithImpl<$Res>
    implements _$AddGroupStateCopyWith<$Res> {
  __$AddGroupStateCopyWithImpl(this._self, this._then);

  final _AddGroupState _self;
  final $Res Function(_AddGroupState) _then;

/// Create a copy of AddGroupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,Object? groupName = null,Object? currency = null,Object? people = null,Object? isAdded = null,}) {
  return _then(_AddGroupState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self._people : people // ignore: cast_nullable_to_non_nullable
as List<Person>,isAdded: null == isAdded ? _self.isAdded : isAdded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
