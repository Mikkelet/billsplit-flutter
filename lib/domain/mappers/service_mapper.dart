import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/service_dto.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';

extension ServicesDtoExt on List<ServiceDTO> {
  List<SubscriptionService> toServices() => map((e) => e.toService()).toList();

  List<ServiceDb> toDb(String groupId) => map((e) => e.toDb(groupId)).toList();
}

extension ServiceDtoExt on ServiceDTO {
  ServiceDb toDb(String groupId) =>
      ServiceDb(id: id, groupId: groupId, service: json.encode(this));

  SubscriptionService toService() {
    return SubscriptionService(
        id: id,
        name: name,
        createdBy: createdBy.toPerson(),
        imageUrl: imageUrl,
        monthlyExpense: monthlyExpense,
        payer: payer.toPerson(),
        participants: participants.toPeople());
  }
}

extension ServicesDbExt on Iterable<ServiceDb> {
  Iterable<SubscriptionService> toServices() => map((e) => e.toService());
}

extension ServiceDbExt on ServiceDb {
  ServiceDTO toDto() => ServiceDTO.fromJson(json.decode(service));

  SubscriptionService toService() => toDto().toService();
}
