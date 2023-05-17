import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class CurrencyConverter {
  final _sharedPrefs = getIt<SharedPrefs>();

  num convert(num amount, String currencySymbol, String convertToCurrency) {
    if (amount == 0) return 0;
    if (currencySymbol.toLowerCase() == convertToCurrency.toLowerCase()) {
      return amount;
    }
    final latestRates = _sharedPrefs.latestExchangeRates;
    final rateForCurrentCurrency = latestRates[currencySymbol.toUpperCase()]!;
    final rateForNewCurrency = latestRates[convertToCurrency.toUpperCase()]!;
    // convert amount to USD
    final amountUSD = amount / rateForCurrentCurrency;

    // multiply amount by new conversion rate
    return amountUSD * rateForNewCurrency;
  }

  num convertToUSD(num expense, String fromCurrency) {
    return convert(expense, fromCurrency, "usd");
  }

  num convertFromUSD(num expense, String toCurrency) {
    return convert(expense, "usd", toCurrency);
  }

  num convertToUserDefault(num expense, String fromCurrency) {
    return convert(expense, fromCurrency, _sharedPrefs.userPrefDefaultCurrency);
  }
}
