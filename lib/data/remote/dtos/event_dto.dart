import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

import 'individual_expense_dto.dart';

part 'event_dto.g.dart';

@JsonSerializable(createToJson: false, createFactory: false)
class EventDTO { // cannot be abstract because of json serializer
  final String type;
  final String id;
  final PersonDTO createdBy;
  final num timeStamp;

  EventDTO(this.id, this.createdBy, this.timeStamp, this.type);

  static EventDTO? fromJson(Json json) {
    try {
      final type = json["type"] as String;
      switch (type) {
        case "expense":
          return GroupExpenseDTO.fromJson(json);
        case "payment":
          return PaymentDTO.fromJson(json);
        default:
          return null;
      }
    } on Exception catch (err, _) {
      print(err);
      return null;
    }
  }
}

@JsonSerializable()
class GroupExpenseDTO extends EventDTO {
  final String description;
  final PersonDTO payee;
  final num sharedExpense;
  final List<IndividualExpenseDTO> individualExpenses;

  GroupExpenseDTO(super.id, super.createdBy, super.timeStamp, super.type,
      this.description, this.payee, this.sharedExpense, this.individualExpenses);

  factory GroupExpenseDTO.fromJson(Json json) =>
        _$GroupExpenseDTOFromJson(json);

  Json toJson() => _$GroupExpenseDTOToJson(this);
}

@JsonSerializable()
class PaymentDTO extends EventDTO {
  final PersonDTO paidTo;
  final num amount;

  PaymentDTO(super.id, super.createdBy, super.timeStamp, super.type,
      this.paidTo, this.amount);

  factory PaymentDTO.fromJson(Json json) => _$PaymentDTOFromJson(json);

  Json toJson() => _$PaymentDTOToJson(this);
}
