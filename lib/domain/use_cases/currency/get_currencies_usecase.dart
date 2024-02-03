import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';

class GetCurrenciesUseCase {
  final _prefs = getIt<SharedPrefs>();

  Iterable<Currency> launch() {
    final rates = _prefs.latestExchangeRates;
    return rates.keys.map((symbol) {
      final rate = _prefs.latestExchangeRates[symbol]!;
      return Currency(symbol: symbol, rate: rate);
    });
  }
}
