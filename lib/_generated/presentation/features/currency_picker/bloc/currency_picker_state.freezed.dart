// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/currency_picker/bloc/currency_picker_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrencyPickerState {

 bool get isLoading; SplitsbyError get error; List<Currency> get currencies; String get filter;
/// Create a copy of CurrencyPickerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyPickerStateCopyWith<CurrencyPickerState> get copyWith => _$CurrencyPickerStateCopyWithImpl<CurrencyPickerState>(this as CurrencyPickerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyPickerState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.currencies, currencies)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,const DeepCollectionEquality().hash(currencies),filter);

@override
String toString() {
  return 'CurrencyPickerState(isLoading: $isLoading, error: $error, currencies: $currencies, filter: $filter)';
}


}

/// @nodoc
abstract mixin class $CurrencyPickerStateCopyWith<$Res>  {
  factory $CurrencyPickerStateCopyWith(CurrencyPickerState value, $Res Function(CurrencyPickerState) _then) = _$CurrencyPickerStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, SplitsbyError error, List<Currency> currencies, String filter
});




}
/// @nodoc
class _$CurrencyPickerStateCopyWithImpl<$Res>
    implements $CurrencyPickerStateCopyWith<$Res> {
  _$CurrencyPickerStateCopyWithImpl(this._self, this._then);

  final CurrencyPickerState _self;
  final $Res Function(CurrencyPickerState) _then;

/// Create a copy of CurrencyPickerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? error = null,Object? currencies = null,Object? filter = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,currencies: null == currencies ? _self.currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrencyPickerState].
extension CurrencyPickerStatePatterns on CurrencyPickerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrencyPickerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrencyPickerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrencyPickerState value)  $default,){
final _that = this;
switch (_that) {
case _CurrencyPickerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrencyPickerState value)?  $default,){
final _that = this;
switch (_that) {
case _CurrencyPickerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  List<Currency> currencies,  String filter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrencyPickerState() when $default != null:
return $default(_that.isLoading,_that.error,_that.currencies,_that.filter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  SplitsbyError error,  List<Currency> currencies,  String filter)  $default,) {final _that = this;
switch (_that) {
case _CurrencyPickerState():
return $default(_that.isLoading,_that.error,_that.currencies,_that.filter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  SplitsbyError error,  List<Currency> currencies,  String filter)?  $default,) {final _that = this;
switch (_that) {
case _CurrencyPickerState() when $default != null:
return $default(_that.isLoading,_that.error,_that.currencies,_that.filter);case _:
  return null;

}
}

}

/// @nodoc


class _CurrencyPickerState implements CurrencyPickerState {
  const _CurrencyPickerState({this.isLoading = false, this.error = const SplitsbyError.none(), final  List<Currency> currencies = const [], this.filter = ""}): _currencies = currencies;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  SplitsbyError error;
 final  List<Currency> _currencies;
@override@JsonKey() List<Currency> get currencies {
  if (_currencies is EqualUnmodifiableListView) return _currencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_currencies);
}

@override@JsonKey() final  String filter;

/// Create a copy of CurrencyPickerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrencyPickerStateCopyWith<_CurrencyPickerState> get copyWith => __$CurrencyPickerStateCopyWithImpl<_CurrencyPickerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrencyPickerState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._currencies, _currencies)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,error,const DeepCollectionEquality().hash(_currencies),filter);

@override
String toString() {
  return 'CurrencyPickerState(isLoading: $isLoading, error: $error, currencies: $currencies, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$CurrencyPickerStateCopyWith<$Res> implements $CurrencyPickerStateCopyWith<$Res> {
  factory _$CurrencyPickerStateCopyWith(_CurrencyPickerState value, $Res Function(_CurrencyPickerState) _then) = __$CurrencyPickerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, SplitsbyError error, List<Currency> currencies, String filter
});




}
/// @nodoc
class __$CurrencyPickerStateCopyWithImpl<$Res>
    implements _$CurrencyPickerStateCopyWith<$Res> {
  __$CurrencyPickerStateCopyWithImpl(this._self, this._then);

  final _CurrencyPickerState _self;
  final $Res Function(_CurrencyPickerState) _then;

/// Create a copy of CurrencyPickerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? error = null,Object? currencies = null,Object? filter = null,}) {
  return _then(_CurrencyPickerState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as SplitsbyError,currencies: null == currencies ? _self._currencies : currencies // ignore: cast_nullable_to_non_nullable
as List<Currency>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
