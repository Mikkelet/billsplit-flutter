import 'package:billsplit_flutter/data/currency_converter.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class ConvertCurrencyUseCase {
  final _converter = getIt<CurrencyConverter>();

  num launch(num amount, String currencySymbol, String convertToCurrency) {
    return _converter.convert(amount, currencySymbol, convertToCurrency);
  }
}
