import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/domain/mappers/currency_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';

extension PaymentsDto on Iterable<PaymentDTO> {
  List<PaymentDb> toDb(String groupId) => map((e) => e.toDb(groupId)).toList();

  List<Payment> toPayments() => map((e) => e.toPayment()).toList();
}

extension PaymentDtoExt on PaymentDTO {
  PaymentDb toDb(String groupId) =>
      PaymentDb(id: id, groupId: groupId, payment: json.encode(this));

  Payment toPayment() => Payment(
      id: id,
      currency: currency.toCurrency(),
      createdBy: createdBy.toPerson(),
      timestamp: timestamp,
      paidTo: paidTo.toPerson(),
      amount: amount);
}

extension PaymentsDbExt on Iterable<PaymentDb> {
  Iterable<Payment> toPayments() => map((e) => e.toPayment());
}

extension PaymentDbExt on PaymentDb {
  PaymentDTO toDTO() => PaymentDTO.fromJson(json.decode(payment));

  Payment toPayment() => toDTO().toPayment();
}
