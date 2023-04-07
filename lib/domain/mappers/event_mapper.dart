import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/domain/mappers/individual_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';

extension EventsExt on List<EventDTO?> {
  List<Event> toEvents() => map((e) => e.toEvent()).whereType<Event>().toList();
}

extension EventExt on EventDTO? {
  Event? toEvent() {
    if (this is GroupExpenseDTO) {
      return GroupExpense(
        id: this!.id,
        timestamp: this!.timeStamp,
        createdBy: this!.createdBy.toPerson(),
        payer: (this as GroupExpenseDTO).payee.toPerson(),
        sharedExpense: (this as GroupExpenseDTO).sharedExpense,
        individualExpenses: (this as GroupExpenseDTO).individualExpenses.toExpenses(),
      );
    }
    return null;
  }
}
