import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/dtos/shared_expense_dto.g.dart';

@JsonSerializable()
class SharedExpenseDTO {
  final String description;
  final Iterable<PersonDTO> participants;
  final num expense;

  SharedExpenseDTO(this.description, this.participants, this.expense);

  factory SharedExpenseDTO.fromJson(Json json) => _$SharedExpenseDTOFromJson(json);

  Json toJson() => _$SharedExpenseDTOToJson(this);
}