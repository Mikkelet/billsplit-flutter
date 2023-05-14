import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency_dto.g.dart';

@JsonSerializable()
class CurrencyDTO {
  final String symbol;
  final double rateSnapshot;

  CurrencyDTO({required this.symbol, required this.rateSnapshot});

  Json toJson() => _$CurrencyDTOToJson(this);

  factory CurrencyDTO.fromJson(Json json) => _$CurrencyDTOFromJson(json);
}
