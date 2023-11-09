import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../../generated/local/preferences/models/recent_currency.g.dart';

@JsonSerializable()
class RecentCurrency extends Comparable<dynamic> {
  final String symbol;
  final int timestamp;

  RecentCurrency(this.symbol, this.timestamp);

  Json toJson() => _$RecentCurrencyToJson(this);

  factory RecentCurrency.fromJson(Json json) => _$RecentCurrencyFromJson(json);

  @override
  int compareTo(dynamic other) {
    if (other != RecentCurrency) return 1;
    final cast = other as RecentCurrency;
    if (cast.timestamp > timestamp) return 1;
    if (cast.timestamp == timestamp) return -1;
    return -1;
  }
}
