import 'package:billsplit_flutter/data/remote/dtos/debts_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_expense_request.g.dart';

@JsonSerializable(createFactory: false)
class DeleteExpenseRequest {
  final Iterable<DebtDTO> debts;

  DeleteExpenseRequest(this.debts);

  Json toJson() => _$DeleteExpenseRequestToJson(this);
}