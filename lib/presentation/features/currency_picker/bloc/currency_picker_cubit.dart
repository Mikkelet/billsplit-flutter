import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/convert_currency_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/get_currencies_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/get_exchange_rates_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/bloc/currency_picker_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/src/widgets/editable_text.dart';

class CurrencyPickerCubit extends SafeCubit<CurrencyPickerState> {
  final _getCurrenciesUseCase = GetCurrenciesUseCase();
  final _getExchangeRatesUseCase = GetExchangeRatesUseCase();
  final _convertCurrencyUseCase = ConvertCurrencyUseCase();
  final SharedPrefs _sharedPrefs;

  final String? convertToCurrency;
  final filterController = TextEditingController();

  Iterable<Currency> get recentCurrencies {
    return _sharedPrefs.recentCurrencies.take(5);
  }

  CurrencyPickerCubit(this._sharedPrefs, {this.convertToCurrency})
    : super(const CurrencyPickerState()) {
    loadCurrencies();
    loadCurrenciesAsync();
  }

  void loadCurrencies() {
    try {
      safeEmit(state.copyWith(isLoading: true));
      final currencies = _getCurrenciesUseCase.launch().toList().sortedBy((e) => e.symbol);
      safeEmit(state.copyWith(currencies: currencies));
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  Future loadCurrenciesAsync() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _getExchangeRatesUseCase.launch();
      loadCurrencies();
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  num getRateForCurrency(String currency) {
    final convertTo = convertToCurrency ?? _sharedPrefs.userPrefDefaultCurrency;
    return _convertCurrencyUseCase.launch(1, currency.toUpperCase(), convertTo);
  }

  void onCurrencyPressed(Currency currency) {
    final recentWithoutSelected = recentCurrencies.where(
      (element) => element.symbol != currency.symbol,
    );
    _sharedPrefs.recentCurrencies = [currency, ...recentWithoutSelected];
  }
}
