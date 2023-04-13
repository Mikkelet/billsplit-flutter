import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/domain/mappers/individual_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';

extension EventDTOsExt on List<EventDTO?> {
  List<Event> toEvents() => map((e) => e.toEvent()).whereType<Event>().toList();
}

extension EventDTOExt on EventDTO? {
  Event? toEvent() {
    if (this is GroupExpenseDTO) {
      return GroupExpense(
        id: this!.id,
        timestamp: this!.timeStamp,
        description: (this as GroupExpenseDTO).description,
        createdBy: this!.createdBy.toPerson(),
        payer: (this as GroupExpenseDTO).payee.toPerson(),
        sharedExpense: (this as GroupExpenseDTO).sharedExpense,
        individualExpenses:
            (this as GroupExpenseDTO).individualExpenses.toExpenses(),
      );
    }
    return null;
  }
}

extension EventExt on Event {
  EventDTO toEventDTO() {
    if (this is GroupExpense) {
      return GroupExpenseDTO(
          id,
          createdBy.toDTO(),
          timestamp,
          "expense",
          (this as GroupExpense).description,
          (this as GroupExpense).payer.toDTO(),
          (this as GroupExpense).sharedExpense.expenseState,
          (this as GroupExpense).individualExpenses.toDTOs());
    }
    return PaymentDTO(id, createdBy.toDTO(), timestamp, "payment",
        (this as Payment).paidTo.toDTO(), (this as Payment).amount);
  }
}
