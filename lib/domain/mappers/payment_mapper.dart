import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';

extension PaymentDtoExt on PaymentDTO {
  PaymentDb toDb(String groupId) =>
      PaymentDb(id: id, groupId: groupId, payment: json.encode(this));

  Payment toPayment() =>
      Payment(id, createdBy.toPerson(), timeStamp, paidTo.toPerson(), amount);
}
