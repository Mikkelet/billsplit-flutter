import 'package:billsplit_flutter/data/remote/dtos/currency_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/shared_expense_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_pretty/json_pretty.dart';

part '../../../generated/remote/dtos/event_dto.g.dart';

@JsonSerializable()
class EventDTO {
  // cannot be abstract because of json serializer
  final String type;
  final String id;
  final PersonDTO createdBy;
  final num timestamp;

  EventDTO({
    required this.id,
    required this.createdBy,
    required this.timestamp,
    required this.type,
  });

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

  Json toJson() {
    if (this is GroupExpenseDTO) {
      return (this as GroupExpenseDTO).toJson();
    } else if (this is PaymentDTO) {
      return (this as PaymentDTO).toJson();
    } else {
      return toJson();
    }
  }
}

@JsonSerializable()
class GroupExpenseDTO extends EventDTO {
  final String description;
  final PersonDTO payee;
  final CurrencyDTO currency;
  final String date;
  final Iterable<SharedExpenseDTO> sharedExpenses;
  final Iterable<PersonDTO> tempParticipants;
  final String receiptImageUrl;

  GroupExpenseDTO({
    required super.id,
    required super.createdBy,
    required super.timestamp,
    super.type = "expense",
    required this.date,
    required this.receiptImageUrl,
    required this.description,
    required this.currency,
    required this.tempParticipants,
    required this.payee,
    required this.sharedExpenses,
  });

  factory GroupExpenseDTO.fromJson(Json json) =>
      _$GroupExpenseDTOFromJson(json);

  @override
  Json toJson() => _$GroupExpenseDTOToJson(this);
}

@JsonSerializable()
class PaymentDTO extends EventDTO {
  final PersonDTO paidTo;
  final num amount;
  final CurrencyDTO currency;
  final PersonDTO paidBy;

  PaymentDTO({
    required super.id,
    required super.createdBy,
    required super.timestamp,
    super.type = "payment",
    required this.currency,
    required this.paidBy,
    required this.paidTo,
    required this.amount,
  });

  factory PaymentDTO.fromJson(Json json) => _$PaymentDTOFromJson(json);

  @override
  Json toJson() => _$PaymentDTOToJson(this);

  @override
  String toString() {
    return prettyPrintJson(toJson().toString());
  }
}
