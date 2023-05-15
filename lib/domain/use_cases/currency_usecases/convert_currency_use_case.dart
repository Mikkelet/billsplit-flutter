import 'package:billsplit_flutter/data/currency_converter.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class ConvertCurrencyUseCase {
  final converter = getIt<CurrencyConverter>();

  num launch(num amount, String currencySymbol, String convertToCurrency) {
    return converter.convert(amount, currencySymbol, convertToCurrency);
  }
}
