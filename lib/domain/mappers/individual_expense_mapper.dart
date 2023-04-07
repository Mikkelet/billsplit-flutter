import 'package:billsplit_flutter/data/remote/dtos/individual_expense_dto.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';

extension IndividualExpensesExt on List<IndividualExpenseDTO> {
  List<IndividualExpense> toExpenses() => map((e) => e.toExpense()).toList();
}

extension IndividualExpenseExt on IndividualExpenseDTO {
  IndividualExpense toExpense() => IndividualExpense(
      person: person.toPerson(),
      expense: expense,
      isParticipant: isParticipant);
}
