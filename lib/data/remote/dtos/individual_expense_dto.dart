import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'individual_expense_dto.g.dart';

@JsonSerializable()
class IndividualExpenseDTO {
  final PersonDTO person;
  final num expense;

  IndividualExpenseDTO(this.person, this.expense);

  factory IndividualExpenseDTO.fromJson(Json json) => _$IndividualExpenseDTOFromJson(json);
  Json toJson() => _$IndividualExpenseDTOToJson(this);
}