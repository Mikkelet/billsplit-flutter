import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/use_cases/currency_usecases/convert_currency_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/get_currencies_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:collection/collection.dart';

class CurrencyPickerCubit extends BaseCubit {
  final _getCurrenciesUseCase = GetCurrenciesUseCase();
  final _convertCurrencyUseCase = ConvertCurrencyUseCase();
  late List<Currency> currencies;

  CurrencyPickerCubit() : super.withState(Loading());

  loadCurrencies() {
    showLoading();
    Future.value(
            _getCurrenciesUseCase.launch().toList().sortedBy((e) => e.symbol))
        .then((value) {
      currencies = value;
      emit(Main());
    });
  }

  num getRateForCurrency(Currency currency) {
    return _convertCurrencyUseCase.launch(
        1, currency.symbol, sharedPrefs.userPrefDefaultCurrency);
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
