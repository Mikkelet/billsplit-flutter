import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/convert_currency_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/get_currencies_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/get_exchange_rates_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:collection/collection.dart';

class CurrencyPickerCubit extends BaseCubit {
  final _getCurrenciesUseCase = GetCurrenciesUseCase();
  final _getExchangeRatesUsecase = GetExchangeRatesUseCase();
  final _convertCurrencyUseCase = ConvertCurrencyUseCase();
  final String? convertToCurrency;
  late List<Currency> currencies;

  CurrencyPickerCubit(this.convertToCurrency) : super.withState(Loading());

  loadCurrencies() {
    showLoading();
    currencies =
        _getCurrenciesUseCase.launch().toList().sortedBy((e) => e.symbol);
    update();
  }

  Future loadCurrenciesAsync() async {
    showLoading();
    try {
      await _getExchangeRatesUsecase.launch();
      loadCurrencies();
    } catch (e, st) {
      showError(e, st);
    }
  }

  num getRateForCurrency(String currency) {
    final convertTo = convertToCurrency ?? sharedPrefs.userPrefDefaultCurrency;
    return _convertCurrencyUseCase.launch(1, currency.toUpperCase(), convertTo);
  }

  Iterable<Currency> get recentCurrencies {
    return sharedPrefs.recentCurrencies.take(5);
  }

  void onCurrencyPressed(Currency currency) {
    final recentWithoutSelected =
        recentCurrencies.where((element) => element.symbol != currency.symbol);
    sharedPrefs.recentCurrencies = [currency, ...recentWithoutSelected];
  }
}
