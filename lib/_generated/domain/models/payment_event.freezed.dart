// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../domain/models/payment_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Payment {

 Person get paidTo; Person get paidBy; num get amount; Currency get currency; String get id; Person get createdBy; int get timestamp;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.paidTo, paidTo) || other.paidTo == paidTo)&&(identical(other.paidBy, paidBy) || other.paidBy == paidBy)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.id, id) || other.id == id)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,paidTo,paidBy,amount,currency,id,createdBy,timestamp);

@override
String toString() {
  return 'Payment(paidTo: $paidTo, paidBy: $paidBy, amount: $amount, currency: $currency, id: $id, createdBy: $createdBy, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 Person paidTo, Person paidBy, num amount, Currency currency, String id, Person createdBy, int timestamp
});


$PersonCopyWith<$Res> get paidTo;$PersonCopyWith<$Res> get paidBy;$PersonCopyWith<$Res> get createdBy;

}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paidTo = null,Object? paidBy = null,Object? amount = null,Object? currency = null,Object? id = null,Object? createdBy = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
paidTo: null == paidTo ? _self.paidTo : paidTo // ignore: cast_nullable_to_non_nullable
as Person,paidBy: null == paidBy ? _self.paidBy : paidBy // ignore: cast_nullable_to_non_nullable
as Person,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as Person,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get paidTo {
  
  return $PersonCopyWith<$Res>(_self.paidTo, (value) {
    return _then(_self.copyWith(paidTo: value));
  });
}/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get paidBy {
  
  return $PersonCopyWith<$Res>(_self.paidBy, (value) {
    return _then(_self.copyWith(paidBy: value));
  });
}/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get createdBy {
  
  return $PersonCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Person paidTo,  Person paidBy,  num amount,  Currency currency,  String id,  Person createdBy,  int timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.paidTo,_that.paidBy,_that.amount,_that.currency,_that.id,_that.createdBy,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Person paidTo,  Person paidBy,  num amount,  Currency currency,  String id,  Person createdBy,  int timestamp)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.paidTo,_that.paidBy,_that.amount,_that.currency,_that.id,_that.createdBy,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Person paidTo,  Person paidBy,  num amount,  Currency currency,  String id,  Person createdBy,  int timestamp)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.paidTo,_that.paidBy,_that.amount,_that.currency,_that.id,_that.createdBy,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _Payment extends Payment {
  const _Payment({this.paidTo = const Person(), this.paidBy = const Person(), this.amount = 0, this.currency = Currency.usdValue, this.id = "", this.createdBy = const Person(), this.timestamp = 0}): super._();
  

@override@JsonKey() final  Person paidTo;
@override@JsonKey() final  Person paidBy;
@override@JsonKey() final  num amount;
@override@JsonKey() final  Currency currency;
@override@JsonKey() final  String id;
@override@JsonKey() final  Person createdBy;
@override@JsonKey() final  int timestamp;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.paidTo, paidTo) || other.paidTo == paidTo)&&(identical(other.paidBy, paidBy) || other.paidBy == paidBy)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.id, id) || other.id == id)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,paidTo,paidBy,amount,currency,id,createdBy,timestamp);

@override
String toString() {
  return 'Payment(paidTo: $paidTo, paidBy: $paidBy, amount: $amount, currency: $currency, id: $id, createdBy: $createdBy, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 Person paidTo, Person paidBy, num amount, Currency currency, String id, Person createdBy, int timestamp
});


@override $PersonCopyWith<$Res> get paidTo;@override $PersonCopyWith<$Res> get paidBy;@override $PersonCopyWith<$Res> get createdBy;

}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paidTo = null,Object? paidBy = null,Object? amount = null,Object? currency = null,Object? id = null,Object? createdBy = null,Object? timestamp = null,}) {
  return _then(_Payment(
paidTo: null == paidTo ? _self.paidTo : paidTo // ignore: cast_nullable_to_non_nullable
as Person,paidBy: null == paidBy ? _self.paidBy : paidBy // ignore: cast_nullable_to_non_nullable
as Person,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as Person,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get paidTo {
  
  return $PersonCopyWith<$Res>(_self.paidTo, (value) {
    return _then(_self.copyWith(paidTo: value));
  });
}/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get paidBy {
  
  return $PersonCopyWith<$Res>(_self.paidBy, (value) {
    return _then(_self.copyWith(paidBy: value));
  });
}/// Create a copy of Payment
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
