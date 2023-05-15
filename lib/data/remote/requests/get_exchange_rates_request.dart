import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_exchange_rates_request.g.dart';

@JsonSerializable(createToJson: false)
class GetExchangeRatesRequest {
  final Map<String, num> rates;

  GetExchangeRatesRequest(this.rates);

  factory GetExchangeRatesRequest.fromJson(Json json) => _$GetExchangeRatesRequestFromJson(json);
}