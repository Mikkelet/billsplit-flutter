// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../domain/models/subscription_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionService {

 String get id; String get name; String get currency; String get imageUrl; double get monthlyExpense; Person get createdBy; Person get payer; List<Person> get participants;
/// Create a copy of SubscriptionService
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionServiceCopyWith<SubscriptionService> get copyWith => _$SubscriptionServiceCopyWithImpl<SubscriptionService>(this as SubscriptionService, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.monthlyExpense, monthlyExpense) || other.monthlyExpense == monthlyExpense)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.payer, payer) || other.payer == payer)&&const DeepCollectionEquality().equals(other.participants, participants));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,currency,imageUrl,monthlyExpense,createdBy,payer,const DeepCollectionEquality().hash(participants));

@override
String toString() {
  return 'SubscriptionService(id: $id, name: $name, currency: $currency, imageUrl: $imageUrl, monthlyExpense: $monthlyExpense, createdBy: $createdBy, payer: $payer, participants: $participants)';
}


}

/// @nodoc
abstract mixin class $SubscriptionServiceCopyWith<$Res>  {
  factory $SubscriptionServiceCopyWith(SubscriptionService value, $Res Function(SubscriptionService) _then) = _$SubscriptionServiceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String currency, String imageUrl, double monthlyExpense, Person createdBy, Person payer, List<Person> participants
});


$PersonCopyWith<$Res> get createdBy;$PersonCopyWith<$Res> get payer;

}
/// @nodoc
class _$SubscriptionServiceCopyWithImpl<$Res>
    implements $SubscriptionServiceCopyWith<$Res> {
  _$SubscriptionServiceCopyWithImpl(this._self, this._then);

  final SubscriptionService _self;
  final $Res Function(SubscriptionService) _then;

/// Create a copy of SubscriptionService
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? currency = null,Object? imageUrl = null,Object? monthlyExpense = null,Object? createdBy = null,Object? payer = null,Object? participants = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,monthlyExpense: null == monthlyExpense ? _self.monthlyExpense : monthlyExpense // ignore: cast_nullable_to_non_nullable
as double,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as Person,payer: null == payer ? _self.payer : payer // ignore: cast_nullable_to_non_nullable
as Person,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<Person>,
  ));
}
/// Create a copy of SubscriptionService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get createdBy {
  
  return $PersonCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}/// Create a copy of SubscriptionService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get payer {
  
  return $PersonCopyWith<$Res>(_self.payer, (value) {
    return _then(_self.copyWith(payer: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubscriptionService].
extension SubscriptionServicePatterns on SubscriptionService {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionService value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionService() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionService value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionService():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionService value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionService() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String currency,  String imageUrl,  double monthlyExpense,  Person createdBy,  Person payer,  List<Person> participants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionService() when $default != null:
return $default(_that.id,_that.name,_that.currency,_that.imageUrl,_that.monthlyExpense,_that.createdBy,_that.payer,_that.participants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String currency,  String imageUrl,  double monthlyExpense,  Person createdBy,  Person payer,  List<Person> participants)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionService():
return $default(_that.id,_that.name,_that.currency,_that.imageUrl,_that.monthlyExpense,_that.createdBy,_that.payer,_that.participants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String currency,  String imageUrl,  double monthlyExpense,  Person createdBy,  Person payer,  List<Person> participants)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionService() when $default != null:
return $default(_that.id,_that.name,_that.currency,_that.imageUrl,_that.monthlyExpense,_that.createdBy,_that.payer,_that.participants);case _:
  return null;

}
}

}

/// @nodoc


class _SubscriptionService extends SubscriptionService {
  const _SubscriptionService({this.id = "", this.name = "", this.currency = "", this.imageUrl = "", this.monthlyExpense = 0, this.createdBy = const Person(), this.payer = const Person(), final  List<Person> participants = const []}): _participants = participants,super._();
  

@override@JsonKey() final  String id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String currency;
@override@JsonKey() final  String imageUrl;
@override@JsonKey() final  double monthlyExpense;
@override@JsonKey() final  Person createdBy;
@override@JsonKey() final  Person payer;
 final  List<Person> _participants;
@override@JsonKey() List<Person> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}


/// Create a copy of SubscriptionService
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionServiceCopyWith<_SubscriptionService> get copyWith => __$SubscriptionServiceCopyWithImpl<_SubscriptionService>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.monthlyExpense, monthlyExpense) || other.monthlyExpense == monthlyExpense)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.payer, payer) || other.payer == payer)&&const DeepCollectionEquality().equals(other._participants, _participants));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,currency,imageUrl,monthlyExpense,createdBy,payer,const DeepCollectionEquality().hash(_participants));

@override
String toString() {
  return 'SubscriptionService(id: $id, name: $name, currency: $currency, imageUrl: $imageUrl, monthlyExpense: $monthlyExpense, createdBy: $createdBy, payer: $payer, participants: $participants)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionServiceCopyWith<$Res> implements $SubscriptionServiceCopyWith<$Res> {
  factory _$SubscriptionServiceCopyWith(_SubscriptionService value, $Res Function(_SubscriptionService) _then) = __$SubscriptionServiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String currency, String imageUrl, double monthlyExpense, Person createdBy, Person payer, List<Person> participants
});


@override $PersonCopyWith<$Res> get createdBy;@override $PersonCopyWith<$Res> get payer;

}
/// @nodoc
class __$SubscriptionServiceCopyWithImpl<$Res>
    implements _$SubscriptionServiceCopyWith<$Res> {
  __$SubscriptionServiceCopyWithImpl(this._self, this._then);

  final _SubscriptionService _self;
  final $Res Function(_SubscriptionService) _then;

/// Create a copy of SubscriptionService
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? currency = null,Object? imageUrl = null,Object? monthlyExpense = null,Object? createdBy = null,Object? payer = null,Object? participants = null,}) {
  return _then(_SubscriptionService(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,monthlyExpense: null == monthlyExpense ? _self.monthlyExpense : monthlyExpense // ignore: cast_nullable_to_non_nullable
as double,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as Person,payer: null == payer ? _self.payer : payer // ignore: cast_nullable_to_non_nullable
as Person,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<Person>,
  ));
}

/// Create a copy of SubscriptionService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get createdBy {
  
  return $PersonCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}/// Create a copy of SubscriptionService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get payer {
  
  return $PersonCopyWith<$Res>(_self.payer, (value) {
    return _then(_self.copyWith(payer: value));
  });
}
}

// dart format on
