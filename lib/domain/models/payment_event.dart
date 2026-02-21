import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../_generated/domain/models/payment_event.freezed.dart';

@freezed
abstract class Payment extends Event with _$Payment {
  const factory Payment({
    @Default(Person()) Person paidTo,
    @Default(Person()) Person paidBy,
    @Default(0) num amount,
    @Default(Currency.usdValue) Currency currency,
    @Default("") String id,
    @Default(Person()) Person createdBy,
    @Default(0) int timestamp,
  }) = _Payment;

  const Payment._() : super("", const Person(), 0);
}
