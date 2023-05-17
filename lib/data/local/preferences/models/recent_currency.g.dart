// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentCurrency _$RecentCurrencyFromJson(Map<String, dynamic> json) =>
    RecentCurrency(
      json['symbol'] as String,
      json['timestamp'] as int,
    );

Map<String, dynamic> _$RecentCurrencyToJson(RecentCurrency instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'timestamp': instance.timestamp,
    };
