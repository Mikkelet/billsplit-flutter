import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class GetExchangeRatesUseCase {
  final _prefs = getIt<SharedPrefs>();

  launch(String symbol) {
    final rates = _prefs.latestExchangeRates;
    final rate = rates[symbol];
    if (rate == null) {
      throw Exception("Invalid rate for ${symbol.toUpperCase()}");
    }
    return rate;
  }
}
