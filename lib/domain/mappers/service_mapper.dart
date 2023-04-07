import 'package:billsplit_flutter/data/remote/dtos/service_dto.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';

extension ServicesDtoExt on List<ServiceDTO> {
  List<SubscriptionService> toServices() => map((e) => e.toService()).toList();
}

extension ServiceDtoExt on ServiceDTO {
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
