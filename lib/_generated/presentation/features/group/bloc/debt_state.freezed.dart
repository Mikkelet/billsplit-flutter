// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/group/bloc/debt_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebtState {

 bool get isLoading; SplitsbyError get error; Group get group; Person get debtee; double get amount; String get currency;
/// Create a copy of DebtState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtStateCopyWith<DebtState> get copyWith => _$DebtStateCopyWithImpl<DebtState>(this as DebtState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.group, group) || other.group == group)&&(identical(other.debtee, debtee) || other.debtee == debtee)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,group,debtee,amount,currency);

@override
String toString() {
  return 'DebtState(isLoading: $isLoading, error: $error, group: $group, debtee: $debtee, amount: $amount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $DebtStateCopyWith<$Res>  {
  factory $DebtStateCopyWith(DebtState value, $Res Function(DebtState) _then) = _$DebtStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SplitsbyError error, Group group, Person debtee, double amount, String currency
});


$GroupCopyWith<$Res> get group;$PersonCopyWith<$Res> get debtee;

}
/// @nodoc
class _$DebtStateCopyWithImpl<$Res>
    implements $DebtStateCopyWith<$Res> {
  _$DebtStateCopyWithImpl(this._self, this._then);

  final DebtState _self;
  final $Res Function(DebtState) _then;

/// Create a copy of DebtState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,Object? group = null,Object? debtee = null,Object? amount = null,Object? currency = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as Group,debtee: null == debtee ? _self.debtee : debtee // ignore: cast_nullable_to_non_nullable
as Person,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of DebtState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res> get group {
  
  return $GroupCopyWith<$Res>(_self.group, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of DebtState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get debtee {
  
  return $PersonCopyWith<$Res>(_self.debtee, (value) {
    return _then(_self.copyWith(debtee: value));
  });
}
}


/// Adds pattern-matching-related methods to [DebtState].
extension DebtStatePatterns on DebtState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtState value)  $default,){
final _that = this;
switch (_that) {
case _DebtState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtState value)?  $default,){
final _that = this;
switch (_that) {
case _DebtState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  Group group,  Person debtee,  double amount,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtState() when $default != null:
return $default(_that.isLoading,_that.error,_that.group,_that.debtee,_that.amount,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  Group group,  Person debtee,  double amount,  String currency)  $default,) {final _that = this;
switch (_that) {
case _DebtState():
return $default(_that.isLoading,_that.error,_that.group,_that.debtee,_that.amount,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  SplitsbyError error,  Group group,  Person debtee,  double amount,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _DebtState() when $default != null:
return $default(_that.isLoading,_that.error,_that.group,_that.debtee,_that.amount,_that.currency);case _:
  return null;

}
}

}

/// @nodoc


class _DebtState implements DebtState {
  const _DebtState({this.isLoading = false, this.error = const SplitsbyError.none(), this.group = const Group(), this.debtee = const Person(), this.amount = 0, this.currency = ""});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SplitsbyError error;
@override@JsonKey() final  Group group;
@override@JsonKey() final  Person debtee;
@override@JsonKey() final  double amount;
@override@JsonKey() final  String currency;

/// Create a copy of DebtState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtStateCopyWith<_DebtState> get copyWith => __$DebtStateCopyWithImpl<_DebtState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.group, group) || other.group == group)&&(identical(other.debtee, debtee) || other.debtee == debtee)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,group,debtee,amount,currency);

@override
String toString() {
  return 'DebtState(isLoading: $isLoading, error: $error, group: $group, debtee: $debtee, amount: $amount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$DebtStateCopyWith<$Res> implements $DebtStateCopyWith<$Res> {
  factory _$DebtStateCopyWith(_DebtState value, $Res Function(_DebtState) _then) = __$DebtStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SplitsbyError error, Group group, Person debtee, double amount, String currency
});


@override $GroupCopyWith<$Res> get group;@override $PersonCopyWith<$Res> get debtee;

}
/// @nodoc
class __$DebtStateCopyWithImpl<$Res>
    implements _$DebtStateCopyWith<$Res> {
  __$DebtStateCopyWithImpl(this._self, this._then);

  final _DebtState _self;
  final $Res Function(_DebtState) _then;

/// Create a copy of DebtState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,Object? group = null,Object? debtee = null,Object? amount = null,Object? currency = null,}) {
  return _then(_DebtState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as Group,debtee: null == debtee ? _self.debtee : debtee // ignore: cast_nullable_to_non_nullable
as Person,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of DebtState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res> get group {
  
  return $GroupCopyWith<$Res>(_self.group, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of DebtState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonCopyWith<$Res> get debtee {
  
  return $PersonCopyWith<$Res>(_self.debtee, (value) {
    return _then(_self.copyWith(debtee: value));
  });
}
}

// dart format on
