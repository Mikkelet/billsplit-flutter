import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'individual_expense_dto.g.dart';

@JsonSerializable()
class IndividualExpenseDTO {
  final PersonDTO person;
  final num expense;
  final bool isParticipant;

  IndividualExpenseDTO(this.person, this.expense, this.isParticipant);

  factory IndividualExpenseDTO.fromJson(Json json) => _$IndividualExpenseDTOFromJson(json);
  Json toJson() => _$IndividualExpenseDTOToJson(this);
}