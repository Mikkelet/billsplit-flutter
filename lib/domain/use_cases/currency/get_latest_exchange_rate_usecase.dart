import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';

class GetExchangeRateUseCase {
  final _prefs = getIt<SharedPrefs>();

  Currency launch(String symbol) {
    final rates = _prefs.latestExchangeRates;
    final rate = rates[symbol.toUpperCase()];
    if (rate == null) {
      throw Exception("Invalid rate for ${symbol.toUpperCase()}");
    }
    return Currency(symbol: symbol, rate: rate);
  }
}
