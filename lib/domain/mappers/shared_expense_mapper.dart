import 'package:billsplit_flutter/data/remote/dtos/shared_expense_dto.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';

extension SharedExpensesExt on Iterable<SharedExpense> {
  Iterable<SharedExpenseDTO> toDTO() => map((e) => e.toDTO());
}

extension SharedExpenseExt on SharedExpense {
  SharedExpenseDTO toDTO() => SharedExpenseDTO(
      descriptionState.value,
      participantsState.value.toDTO(),
      expenseState.value);
}

extension SharedExpenseDtos on Iterable<SharedExpenseDTO> {
  Iterable<SharedExpense> toSharedExpense() => map((e) => e.toSharedExpense());
}

extension SharedExpenseDto on SharedExpenseDTO {
  SharedExpense toSharedExpense() => SharedExpense(
      expense: expense,
      participants: participants.toPeople(),
      description: description);
}
