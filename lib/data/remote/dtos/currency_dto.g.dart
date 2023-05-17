// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyDTO _$CurrencyDTOFromJson(Map<String, dynamic> json) => CurrencyDTO(
      symbol: json['symbol'] as String,
      rateSnapshot: json['rateSnapshot'] as num,
    );

Map<String, dynamic> _$CurrencyDTOToJson(CurrencyDTO instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'rateSnapshot': instance.rateSnapshot,
    };
