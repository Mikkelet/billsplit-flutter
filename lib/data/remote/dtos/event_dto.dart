import 'package:billsplit_flutter/data/remote/dtos/currency_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/shared_expense_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_dto.g.dart';

@JsonSerializable()
class EventDTO {
  // cannot be abstract because of json serializer
  final String type;
  final String id;
  final PersonDTO createdBy;
  final num timestamp;

  EventDTO(
      {required this.id,
      required this.createdBy,
      required this.timestamp,
      required this.type});

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
  final Iterable<SharedExpenseDTO> sharedExpenses;

  GroupExpenseDTO(
      {required String id,
      required PersonDTO createdBy,
      required num timestamp,
      String type = "expense",
      required this.description,
      required this.currency,
      required this.payee,
      required this.sharedExpenses})
      : super(id: id, createdBy: createdBy, timestamp: timestamp, type: type);

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

  PaymentDTO(
      {required String id,
      required PersonDTO createdBy,
      required num timestamp,
      String type = "payment",
      required this.currency,
      required this.paidTo,
      required this.amount})
      : super(
          id: id,
          createdBy: createdBy,
          timestamp: timestamp,
          type: type,
        );

  factory PaymentDTO.fromJson(Json json) => _$PaymentDTOFromJson(json);

  @override
  Json toJson() => _$PaymentDTOToJson(this);
}
