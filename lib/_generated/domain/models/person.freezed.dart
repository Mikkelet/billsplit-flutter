// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../domain/models/person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Person {

 String get uid; String get name; String get pfpUrl; String get email; PhoneNumber get phoneNumber; bool get isGuest;
/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonCopyWith<Person> get copyWith => _$PersonCopyWithImpl<Person>(this as Person, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Person&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.pfpUrl, pfpUrl) || other.pfpUrl == pfpUrl)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest));
}


@override
int get hashCode => Object.hash(runtimeType,uid,name,pfpUrl,email,phoneNumber,isGuest);

@override
String toString() {
  return 'Person(uid: $uid, name: $name, pfpUrl: $pfpUrl, email: $email, phoneNumber: $phoneNumber, isGuest: $isGuest)';
}


}

/// @nodoc
abstract mixin class $PersonCopyWith<$Res>  {
  factory $PersonCopyWith(Person value, $Res Function(Person) _then) = _$PersonCopyWithImpl;
@useResult
$Res call({
 String uid, String name, String pfpUrl, String email, PhoneNumber phoneNumber, bool isGuest
});


$PhoneNumberCopyWith<$Res> get phoneNumber;

}
/// @nodoc
class _$PersonCopyWithImpl<$Res>
    implements $PersonCopyWith<$Res> {
  _$PersonCopyWithImpl(this._self, this._then);

  final Person _self;
  final $Res Function(Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? name = null,Object? pfpUrl = null,Object? email = null,Object? phoneNumber = null,Object? isGuest = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,pfpUrl: null == pfpUrl ? _self.pfpUrl : pfpUrl // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as PhoneNumber,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhoneNumberCopyWith<$Res> get phoneNumber {
  
  return $PhoneNumberCopyWith<$Res>(_self.phoneNumber, (value) {
    return _then(_self.copyWith(phoneNumber: value));
  });
}
}


/// Adds pattern-matching-related methods to [Person].
extension PersonPatterns on Person {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Person value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Person value)  $default,){
final _that = this;
switch (_that) {
case _Person():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Person value)?  $default,){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String name,  String pfpUrl,  String email,  PhoneNumber phoneNumber,  bool isGuest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.uid,_that.name,_that.pfpUrl,_that.email,_that.phoneNumber,_that.isGuest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String name,  String pfpUrl,  String email,  PhoneNumber phoneNumber,  bool isGuest)  $default,) {final _that = this;
switch (_that) {
case _Person():
return $default(_that.uid,_that.name,_that.pfpUrl,_that.email,_that.phoneNumber,_that.isGuest);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String name,  String pfpUrl,  String email,  PhoneNumber phoneNumber,  bool isGuest)?  $default,) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.uid,_that.name,_that.pfpUrl,_that.email,_that.phoneNumber,_that.isGuest);case _:
  return null;

}
}

}

/// @nodoc


class _Person extends Person {
  const _Person({this.uid = "", this.name = "", this.pfpUrl = "", this.email = "", this.phoneNumber = const PhoneNumber(), this.isGuest = false}): super._();
  

@override@JsonKey() final  String uid;
@override@JsonKey() final  String name;
@override@JsonKey() final  String pfpUrl;
@override@JsonKey() final  String email;
@override@JsonKey() final  PhoneNumber phoneNumber;
@override@JsonKey() final  bool isGuest;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonCopyWith<_Person> get copyWith => __$PersonCopyWithImpl<_Person>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Person&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.pfpUrl, pfpUrl) || other.pfpUrl == pfpUrl)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest));
}


@override
int get hashCode => Object.hash(runtimeType,uid,name,pfpUrl,email,phoneNumber,isGuest);

@override
String toString() {
  return 'Person(uid: $uid, name: $name, pfpUrl: $pfpUrl, email: $email, phoneNumber: $phoneNumber, isGuest: $isGuest)';
}


}

/// @nodoc
abstract mixin class _$PersonCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$PersonCopyWith(_Person value, $Res Function(_Person) _then) = __$PersonCopyWithImpl;
@override @useResult
$Res call({
 String uid, String name, String pfpUrl, String email, PhoneNumber phoneNumber, bool isGuest
});


@override $PhoneNumberCopyWith<$Res> get phoneNumber;

}
/// @nodoc
class __$PersonCopyWithImpl<$Res>
    implements _$PersonCopyWith<$Res> {
  __$PersonCopyWithImpl(this._self, this._then);

  final _Person _self;
  final $Res Function(_Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? name = null,Object? pfpUrl = null,Object? email = null,Object? phoneNumber = null,Object? isGuest = null,}) {
  return _then(_Person(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,pfpUrl: null == pfpUrl ? _self.pfpUrl : pfpUrl // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as PhoneNumber,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhoneNumberCopyWith<$Res> get phoneNumber {
  
  return $PhoneNumberCopyWith<$Res>(_self.phoneNumber, (value) {
    return _then(_self.copyWith(phoneNumber: value));
  });
}
}

// dart format on
