import 'package:billsplit_flutter/domain/models/currency.dart';

class GetCurrenciesUseCase {
  Future<List<Currency>> launch() async {
    return [
      Currency(symbol: "usd", rate: 1),
      Currency(symbol: "eur", rate: 0.91),
      Currency(symbol: "dkk", rate: 6.86),
      Currency(symbol: "thb", rate: 33.79),
    ];
  }
}
