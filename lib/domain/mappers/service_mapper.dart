import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/service_dto.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';

extension ServicesDtoExt on Iterable<ServiceDTO> {
  Iterable<SubscriptionService> toServices() => map((e) => e.toService());

  Iterable<ServiceDb> toDb(String groupId) => map((e) => e.toDb(groupId));
}

extension ServiceDtoExt on ServiceDTO {
  ServiceDb toDb(String groupId) =>
      ServiceDb(id: id, groupId: groupId, service: json.encode(this));

  SubscriptionService toService() {
    return SubscriptionService(
        id: id,
        name: name,
        createdBy: createdBy.toPerson(),
        currency: currency,
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

extension ServiceExt on SubscriptionService {
  ServiceDTO toDTO() => ServiceDTO(
        id: id,
        name: nameState,
        currency: currencyState,
        imageUrl: imageUrl,
        monthlyExpense: monthlyExpenseState,
        createdBy: createdBy.toDTO(),
        participants: participantsState.toDTO(),
        payer: payerState.toDTO(),
      );
}
