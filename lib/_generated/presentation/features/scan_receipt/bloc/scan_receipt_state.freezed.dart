// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../../presentation/features/scan_receipt/bloc/scan_receipt_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScanReceiptState {

 bool get isLoading; bool get isSnappingPhoto; MenuState get menuState; Offset get focusCircleOffset; BarrierDrag get barrierDrag; DecimalDenominator get decimalDenominator; double get upperBarrier; double get lowerBarrier;
/// Create a copy of ScanReceiptState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanReceiptStateCopyWith<ScanReceiptState> get copyWith => _$ScanReceiptStateCopyWithImpl<ScanReceiptState>(this as ScanReceiptState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanReceiptState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSnappingPhoto, isSnappingPhoto) || other.isSnappingPhoto == isSnappingPhoto)&&(identical(other.menuState, menuState) || other.menuState == menuState)&&(identical(other.focusCircleOffset, focusCircleOffset) || other.focusCircleOffset == focusCircleOffset)&&(identical(other.barrierDrag, barrierDrag) || other.barrierDrag == barrierDrag)&&(identical(other.decimalDenominator, decimalDenominator) || other.decimalDenominator == decimalDenominator)&&(identical(other.upperBarrier, upperBarrier) || other.upperBarrier == upperBarrier)&&(identical(other.lowerBarrier, lowerBarrier) || other.lowerBarrier == lowerBarrier));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSnappingPhoto,menuState,focusCircleOffset,barrierDrag,decimalDenominator,upperBarrier,lowerBarrier);

@override
String toString() {
  return 'ScanReceiptState(isLoading: $isLoading, isSnappingPhoto: $isSnappingPhoto, menuState: $menuState, focusCircleOffset: $focusCircleOffset, barrierDrag: $barrierDrag, decimalDenominator: $decimalDenominator, upperBarrier: $upperBarrier, lowerBarrier: $lowerBarrier)';
}


}

/// @nodoc
abstract mixin class $ScanReceiptStateCopyWith<$Res>  {
  factory $ScanReceiptStateCopyWith(ScanReceiptState value, $Res Function(ScanReceiptState) _then) = _$ScanReceiptStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSnappingPhoto, MenuState menuState, Offset focusCircleOffset, BarrierDrag barrierDrag, DecimalDenominator decimalDenominator, double upperBarrier, double lowerBarrier
});




}
/// @nodoc
class _$ScanReceiptStateCopyWithImpl<$Res>
    implements $ScanReceiptStateCopyWith<$Res> {
  _$ScanReceiptStateCopyWithImpl(this._self, this._then);

  final ScanReceiptState _self;
  final $Res Function(ScanReceiptState) _then;

/// Create a copy of ScanReceiptState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSnappingPhoto = null,Object? menuState = null,Object? focusCircleOffset = null,Object? barrierDrag = null,Object? decimalDenominator = null,Object? upperBarrier = null,Object? lowerBarrier = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSnappingPhoto: null == isSnappingPhoto ? _self.isSnappingPhoto : isSnappingPhoto // ignore: cast_nullable_to_non_nullable
as bool,menuState: null == menuState ? _self.menuState : menuState // ignore: cast_nullable_to_non_nullable
as MenuState,focusCircleOffset: null == focusCircleOffset ? _self.focusCircleOffset : focusCircleOffset // ignore: cast_nullable_to_non_nullable
as Offset,barrierDrag: null == barrierDrag ? _self.barrierDrag : barrierDrag // ignore: cast_nullable_to_non_nullable
as BarrierDrag,decimalDenominator: null == decimalDenominator ? _self.decimalDenominator : decimalDenominator // ignore: cast_nullable_to_non_nullable
as DecimalDenominator,upperBarrier: null == upperBarrier ? _self.upperBarrier : upperBarrier // ignore: cast_nullable_to_non_nullable
as double,lowerBarrier: null == lowerBarrier ? _self.lowerBarrier : lowerBarrier // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanReceiptState].
extension ScanReceiptStatePatterns on ScanReceiptState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanReceiptState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanReceiptState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanReceiptState value)  $default,){
final _that = this;
switch (_that) {
case _ScanReceiptState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanReceiptState value)?  $default,){
final _that = this;
switch (_that) {
case _ScanReceiptState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSnappingPhoto,  MenuState menuState,  Offset focusCircleOffset,  BarrierDrag barrierDrag,  DecimalDenominator decimalDenominator,  double upperBarrier,  double lowerBarrier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanReceiptState() when $default != null:
return $default(_that.isLoading,_that.isSnappingPhoto,_that.menuState,_that.focusCircleOffset,_that.barrierDrag,_that.decimalDenominator,_that.upperBarrier,_that.lowerBarrier);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSnappingPhoto,  MenuState menuState,  Offset focusCircleOffset,  BarrierDrag barrierDrag,  DecimalDenominator decimalDenominator,  double upperBarrier,  double lowerBarrier)  $default,) {final _that = this;
switch (_that) {
case _ScanReceiptState():
return $default(_that.isLoading,_that.isSnappingPhoto,_that.menuState,_that.focusCircleOffset,_that.barrierDrag,_that.decimalDenominator,_that.upperBarrier,_that.lowerBarrier);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSnappingPhoto,  MenuState menuState,  Offset focusCircleOffset,  BarrierDrag barrierDrag,  DecimalDenominator decimalDenominator,  double upperBarrier,  double lowerBarrier)?  $default,) {final _that = this;
switch (_that) {
case _ScanReceiptState() when $default != null:
return $default(_that.isLoading,_that.isSnappingPhoto,_that.menuState,_that.focusCircleOffset,_that.barrierDrag,_that.decimalDenominator,_that.upperBarrier,_that.lowerBarrier);case _:
  return null;

}
}

}

/// @nodoc


class _ScanReceiptState implements ScanReceiptState {
  const _ScanReceiptState({this.isLoading = false, this.isSnappingPhoto = false, this.menuState = MenuState.searching, this.focusCircleOffset = Offset.zero, this.barrierDrag = BarrierDrag.none, this.decimalDenominator = DecimalDenominator.comma, this.upperBarrier = 100.0, this.lowerBarrier = 100.0});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSnappingPhoto;
@override@JsonKey() final  MenuState menuState;
@override@JsonKey() final  Offset focusCircleOffset;
@override@JsonKey() final  BarrierDrag barrierDrag;
@override@JsonKey() final  DecimalDenominator decimalDenominator;
@override@JsonKey() final  double upperBarrier;
@override@JsonKey() final  double lowerBarrier;

/// Create a copy of ScanReceiptState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanReceiptStateCopyWith<_ScanReceiptState> get copyWith => __$ScanReceiptStateCopyWithImpl<_ScanReceiptState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanReceiptState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSnappingPhoto, isSnappingPhoto) || other.isSnappingPhoto == isSnappingPhoto)&&(identical(other.menuState, menuState) || other.menuState == menuState)&&(identical(other.focusCircleOffset, focusCircleOffset) || other.focusCircleOffset == focusCircleOffset)&&(identical(other.barrierDrag, barrierDrag) || other.barrierDrag == barrierDrag)&&(identical(other.decimalDenominator, decimalDenominator) || other.decimalDenominator == decimalDenominator)&&(identical(other.upperBarrier, upperBarrier) || other.upperBarrier == upperBarrier)&&(identical(other.lowerBarrier, lowerBarrier) || other.lowerBarrier == lowerBarrier));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSnappingPhoto,menuState,focusCircleOffset,barrierDrag,decimalDenominator,upperBarrier,lowerBarrier);

@override
String toString() {
  return 'ScanReceiptState(isLoading: $isLoading, isSnappingPhoto: $isSnappingPhoto, menuState: $menuState, focusCircleOffset: $focusCircleOffset, barrierDrag: $barrierDrag, decimalDenominator: $decimalDenominator, upperBarrier: $upperBarrier, lowerBarrier: $lowerBarrier)';
}


}

/// @nodoc
abstract mixin class _$ScanReceiptStateCopyWith<$Res> implements $ScanReceiptStateCopyWith<$Res> {
  factory _$ScanReceiptStateCopyWith(_ScanReceiptState value, $Res Function(_ScanReceiptState) _then) = __$ScanReceiptStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSnappingPhoto, MenuState menuState, Offset focusCircleOffset, BarrierDrag barrierDrag, DecimalDenominator decimalDenominator, double upperBarrier, double lowerBarrier
});




}
/// @nodoc
class __$ScanReceiptStateCopyWithImpl<$Res>
    implements _$ScanReceiptStateCopyWith<$Res> {
  __$ScanReceiptStateCopyWithImpl(this._self, this._then);

  final _ScanReceiptState _self;
  final $Res Function(_ScanReceiptState) _then;

/// Create a copy of ScanReceiptState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSnappingPhoto = null,Object? menuState = null,Object? focusCircleOffset = null,Object? barrierDrag = null,Object? decimalDenominator = null,Object? upperBarrier = null,Object? lowerBarrier = null,}) {
  return _then(_ScanReceiptState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSnappingPhoto: null == isSnappingPhoto ? _self.isSnappingPhoto : isSnappingPhoto // ignore: cast_nullable_to_non_nullable
as bool,menuState: null == menuState ? _self.menuState : menuState // ignore: cast_nullable_to_non_nullable
as MenuState,focusCircleOffset: null == focusCircleOffset ? _self.focusCircleOffset : focusCircleOffset // ignore: cast_nullable_to_non_nullable
as Offset,barrierDrag: null == barrierDrag ? _self.barrierDrag : barrierDrag // ignore: cast_nullable_to_non_nullable
as BarrierDrag,decimalDenominator: null == decimalDenominator ? _self.decimalDenominator : decimalDenominator // ignore: cast_nullable_to_non_nullable
as DecimalDenominator,upperBarrier: null == upperBarrier ? _self.upperBarrier : upperBarrier // ignore: cast_nullable_to_non_nullable
as double,lowerBarrier: null == lowerBarrier ? _self.lowerBarrier : lowerBarrier // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
