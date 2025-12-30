import 'dart:ui';

import 'package:billsplit_flutter/domain/models/decimal_denominator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/scan_receipt/bloc/scan_receipt_state.freezed.dart';

@freezed
abstract class ScanReceiptState with _$ScanReceiptState {
  const factory ScanReceiptState({
    @Default(false) bool isLoading,
    @Default(false) bool isSnappingPhoto,
    @Default(MenuState.searching) MenuState menuState,
    @Default(Offset.zero) Offset focusCircleOffset,
    @Default(BarrierDrag.none) BarrierDrag barrierDrag,
    @Default(DecimalDenominator.comma) DecimalDenominator decimalDenominator,
    @Default(100.0) double upperBarrier,
    @Default(100.0) double lowerBarrier,
  }) = _ScanReceiptState;
}

enum BarrierDrag {
  upper,
  lower,
  none;
}

enum MenuState {
  searching,
  receipt,
  settings;
}