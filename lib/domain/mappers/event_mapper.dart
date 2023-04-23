import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/domain/mappers/individual_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/shared_expense_mapper.dart';
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
        sharedExpenses:
            (this as GroupExpenseDTO).sharedExpenses.toSharedExpense(),
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
        (this as GroupExpense).descriptionState,
        (this as GroupExpense).payerState.toDTO(),
        (this as GroupExpense).individualExpenses.toDTOs(),
        (this as GroupExpense).sharedExpenses.toDTO(),
      );
    }
    return PaymentDTO(id, createdBy.toDTO(), timestamp, "payment",
        (this as Payment).paidTo.toDTO(), (this as Payment).amount);
  }
}
