import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/use_cases/currency_usecases/convert_currency_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/get_currencies_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:collection/collection.dart';

class CurrencyPickerCubit extends BaseCubit {
  final _getCurrenciesUseCase = GetCurrenciesUseCase();
  final _convertCurrencyUseCase = ConvertCurrencyUseCase();
  late List<Currency> currencies =
      _getCurrenciesUseCase.launch().toList().sortedBy((e) => e.symbol);

  num getRateForCurrency(Currency currency) {
    return _convertCurrencyUseCase.launch(
        1, currency.symbol, sharedPrefs.userPrefDefaultCurrency);
  }

  Iterable<Currency> get recentCurrencies {
    final removeDuplicates =
        sharedPrefs.recentCurrencies.map((e) => e.symbol).toSet();
    final toCurrencies =
        removeDuplicates.map((e) => Currency(symbol: e, rate: 0));
    return toCurrencies.take(5);
  }

  void onCurrencyPressed(Currency currency) {
    sharedPrefs.addRecentCurrency(currency);
  }
}
