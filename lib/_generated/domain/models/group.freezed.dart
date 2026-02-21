// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../domain/models/group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Group {

 String get id; String get name; String get coverImageUrl; List<Person> get people; List<Person> get pastMembers; List<Person> get invites; Person get createdBy; num get timestamp; int get lastUpdated; int get lastSync; String get defaultCurrency;
/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupCopyWith<Group> get copyWith => _$GroupCopyWithImpl<Group>(this as Group, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Group&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&const DeepCollectionEquality().equals(other.people, people)&&const DeepCollectionEquality().equals(other.pastMembers, pastMembers)&&const DeepCollectionEquality().equals(other.invites, invites)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.lastSync, lastSync) || other.lastSync == lastSync)&&(identical(other.defaultCurrency, defaultCurrency) || other.defaultCurrency == defaultCurrency));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,coverImageUrl,const DeepCollectionEquality().hash(people),const DeepCollectionEquality().hash(pastMembers),const DeepCollectionEquality().hash(invites),createdBy,timestamp,lastUpdated,lastSync,defaultCurrency);

@override
String toString() {
  return 'Group(id: $id, name: $name, coverImageUrl: $coverImageUrl, people: $people, pastMembers: $pastMembers, invites: $invites, createdBy: $createdBy, timestamp: $timestamp, lastUpdated: $lastUpdated, lastSync: $lastSync, defaultCurrency: $defaultCurrency)';
}


}

/// @nodoc
abstract mixin class $GroupCopyWith<$Res>  {
  factory $GroupCopyWith(Group value, $Res Function(Group) _then) = _$GroupCopyWithImpl;
@useResult
$Res call({
 String id, String name, String coverImageUrl, List<Person> people, List<Person> pastMembers, List<Person> invites, Person createdBy, num timestamp, int lastUpdated, int lastSync, String defaultCurrency
});


$PersonCopyWith<$Res> get createdBy;

}
/// @nodoc
class _$GroupCopyWithImpl<$Res>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._self, this._then);

  final Group _self;
  final $Res Function(Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? coverImageUrl = null,Object? people = null,Object? pastMembers = null,Object? invites = null,Object? createdBy = null,Object? timestamp = null,Object? lastUpdated = null,Object? lastSync = null,Object? defaultCurrency = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as List<Person>,pastMembers: null == pastMembers ? _self.pastMembers : pastMembers // ignore: cast_nullable_to_non_nullable
as List<Person>,invites: null == invites ? _self.invites : invites // ignore: cast_nullable_to_non_nullable
as List<Person>,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as Person,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as num,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as int,lastSync: null == lastSync ? _self.lastSync : lastSync // ignore: cast_nullable_to_non_nullable
as int,defaultCurrency: null == defaultCurrency ? _self.defaultCurrency : defaultCurrency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get createdBy {
  
  return $PersonCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [Group].
extension GroupPatterns on Group {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Group value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Group() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Group value)  $default,){
final _that = this;
switch (_that) {
case _Group():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Group value)?  $default,){
final _that = this;
switch (_that) {
case _Group() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String coverImageUrl,  List<Person> people,  List<Person> pastMembers,  List<Person> invites,  Person createdBy,  num timestamp,  int lastUpdated,  int lastSync,  String defaultCurrency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Group() when $default != null:
return $default(_that.id,_that.name,_that.coverImageUrl,_that.people,_that.pastMembers,_that.invites,_that.createdBy,_that.timestamp,_that.lastUpdated,_that.lastSync,_that.defaultCurrency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String coverImageUrl,  List<Person> people,  List<Person> pastMembers,  List<Person> invites,  Person createdBy,  num timestamp,  int lastUpdated,  int lastSync,  String defaultCurrency)  $default,) {final _that = this;
switch (_that) {
case _Group():
return $default(_that.id,_that.name,_that.coverImageUrl,_that.people,_that.pastMembers,_that.invites,_that.createdBy,_that.timestamp,_that.lastUpdated,_that.lastSync,_that.defaultCurrency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String coverImageUrl,  List<Person> people,  List<Person> pastMembers,  List<Person> invites,  Person createdBy,  num timestamp,  int lastUpdated,  int lastSync,  String defaultCurrency)?  $default,) {final _that = this;
switch (_that) {
case _Group() when $default != null:
return $default(_that.id,_that.name,_that.coverImageUrl,_that.people,_that.pastMembers,_that.invites,_that.createdBy,_that.timestamp,_that.lastUpdated,_that.lastSync,_that.defaultCurrency);case _:
  return null;

}
}

}

/// @nodoc


class _Group implements Group {
  const _Group({this.id = "", this.name = "", this.coverImageUrl = "", final  List<Person> people = const [], final  List<Person> pastMembers = const [], final  List<Person> invites = const [], this.createdBy = const Person(), this.timestamp = 0, this.lastUpdated = 0, this.lastSync = 0, this.defaultCurrency = ""}): _people = people,_pastMembers = pastMembers,_invites = invites;
  

@override@JsonKey() final  String id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String coverImageUrl;
 final  List<Person> _people;
@override@JsonKey() List<Person> get people {
  if (_people is EqualUnmodifiableListView) return _people;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_people);
}

 final  List<Person> _pastMembers;
@override@JsonKey() List<Person> get pastMembers {
  if (_pastMembers is EqualUnmodifiableListView) return _pastMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pastMembers);
}

 final  List<Person> _invites;
@override@JsonKey() List<Person> get invites {
  if (_invites is EqualUnmodifiableListView) return _invites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invites);
}

@override@JsonKey() final  Person createdBy;
@override@JsonKey() final  num timestamp;
@override@JsonKey() final  int lastUpdated;
@override@JsonKey() final  int lastSync;
@override@JsonKey() final  String defaultCurrency;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupCopyWith<_Group> get copyWith => __$GroupCopyWithImpl<_Group>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Group&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&const DeepCollectionEquality().equals(other._people, _people)&&const DeepCollectionEquality().equals(other._pastMembers, _pastMembers)&&const DeepCollectionEquality().equals(other._invites, _invites)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.lastSync, lastSync) || other.lastSync == lastSync)&&(identical(other.defaultCurrency, defaultCurrency) || other.defaultCurrency == defaultCurrency));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,coverImageUrl,const DeepCollectionEquality().hash(_people),const DeepCollectionEquality().hash(_pastMembers),const DeepCollectionEquality().hash(_invites),createdBy,timestamp,lastUpdated,lastSync,defaultCurrency);

@override
String toString() {
  return 'Group(id: $id, name: $name, coverImageUrl: $coverImageUrl, people: $people, pastMembers: $pastMembers, invites: $invites, createdBy: $createdBy, timestamp: $timestamp, lastUpdated: $lastUpdated, lastSync: $lastSync, defaultCurrency: $defaultCurrency)';
}


}

/// @nodoc
abstract mixin class _$GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$GroupCopyWith(_Group value, $Res Function(_Group) _then) = __$GroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String coverImageUrl, List<Person> people, List<Person> pastMembers, List<Person> invites, Person createdBy, num timestamp, int lastUpdated, int lastSync, String defaultCurrency
});


@override $PersonCopyWith<$Res> get createdBy;

}
/// @nodoc
class __$GroupCopyWithImpl<$Res>
    implements _$GroupCopyWith<$Res> {
  __$GroupCopyWithImpl(this._self, this._then);

  final _Group _self;
  final $Res Function(_Group) _then;

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? coverImageUrl = null,Object? people = null,Object? pastMembers = null,Object? invites = null,Object? createdBy = null,Object? timestamp = null,Object? lastUpdated = null,Object? lastSync = null,Object? defaultCurrency = null,}) {
  return _then(_Group(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self._people : people // ignore: cast_nullable_to_non_nullable
as List<Person>,pastMembers: null == pastMembers ? _self._pastMembers : pastMembers // ignore: cast_nullable_to_non_nullable
as List<Person>,invites: null == invites ? _self._invites : invites // ignore: cast_nullable_to_non_nullable
as List<Person>,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as Person,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as num,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as int,lastSync: null == lastSync ? _self.lastSync : lastSync // ignore: cast_nullable_to_non_nullable
as int,defaultCurrency: null == defaultCurrency ? _self.defaultCurrency : defaultCurrency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Group
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get createdBy {
  
  return $PersonCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}

// dart format on
