import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/currency_picker/bloc/currency_picker_state.freezed.dart';

@freezed
abstract class CurrencyPickerState with _$CurrencyPickerState {
  const factory CurrencyPickerState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default([]) List<Currency> currencies,
    @Default("") String filter,
  }) = _CurrencyPickerState;
}