import 'package:billsplit_flutter/data/remote/dtos/individual_expense_dto.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';

extension IndividualExpensesDTOExt on Iterable<IndividualExpenseDTO> {
  Iterable<IndividualExpense> toExpenses() => map((e) => e.toExpense());
}

extension IndividualExpenseDTOExt on IndividualExpenseDTO {
  IndividualExpense toExpense() => IndividualExpense(
      person: person.toPerson(),
      expense: expense);
}

extension IndividualExpensesExt on Iterable<IndividualExpense> {
  Iterable<IndividualExpenseDTO> toDTOs() => map((e) => e.toDTO());
}

extension IndividualExpenseExt on IndividualExpense {
  IndividualExpenseDTO toDTO() =>
      IndividualExpenseDTO(person.toDTO(), expenseState);
}
