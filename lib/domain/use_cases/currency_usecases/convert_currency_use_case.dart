import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class ConvertCurrencyUseCase {
  final _prefs = getIt<SharedPrefs>();

  num launch(num amount, String currencySymbol, String convertToCurrency) {
    final response = _prefs.latestExchangeRates;
    final rateForCurrentCurrency = response[currencySymbol.toUpperCase()]!;
    final rateForNewCurrency = response[convertToCurrency.toUpperCase()]!;
    // convert amount to USD
    final amountUSD = amount / rateForCurrentCurrency;

    // multiply amount by new conversion rate
    return amountUSD * rateForNewCurrency;
  }
}
