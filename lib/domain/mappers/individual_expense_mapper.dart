import 'package:billsplit_flutter/data/remote/dtos/individual_expense_dto.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';

extension IndividualExpensesDTOExt on List<IndividualExpenseDTO> {
  List<IndividualExpense> toExpenses() => map((e) => e.toExpense()).toList();
}

extension IndividualExpenseDTOExt on IndividualExpenseDTO {
  IndividualExpense toExpense() => IndividualExpense(
      person: person.toPerson(),
      expense: expense,
      isParticipant: isParticipant);
}

extension IndividualExpensesExt on List<IndividualExpense> {
  List<IndividualExpenseDTO> toDTOs() => map((e) => e.toDTO()).toList();
}

extension IndividualExpenseExt on IndividualExpense {
  IndividualExpenseDTO toDTO() =>
      IndividualExpenseDTO(person.toDTO(), expenseState, isParticipant);
}
