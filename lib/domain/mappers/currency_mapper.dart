import 'package:billsplit_flutter/data/remote/dtos/currency_dto.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';

extension CurrencyDtoExt on CurrencyDTO {
  Currency toCurrency() => Currency(symbol: symbol, rate: rateSnapshot);
}

extension CurrencyExt on Currency {
  CurrencyDTO toDTO() => CurrencyDTO(symbol: symbol, rateSnapshot: rate);
}