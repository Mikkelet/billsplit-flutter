import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/domain/mappers/currency_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/shared_expense_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/utils/constants.dart';

extension EventDTOsExt on List<EventDTO?> {
  List<Event> toEvents() => map((e) => e.toEvent()).whereType<Event>().toList();
}

extension EventDTOExt on EventDTO? {
  Event? toEvent() {
    if (this is GroupExpenseDTO) {
      final expenseDto = this as GroupExpenseDTO;
      return GroupExpense(
          id: this!.id,
          timestamp: this!.timestamp,
          description: expenseDto.description,
          createdBy: this!.createdBy.toPerson(),
          receiptImageUrl: expenseDto.receiptImageUrl,
          date: DateTime.parse(expenseDto.date),
          tempParticipants: expenseDto.tempParticipants.toPeople(),
          payer: expenseDto.payee.toPerson(),
          sharedExpenses: expenseDto.sharedExpenses.toSharedExpense(),
          syncState: SyncState.synced,
          currency: expenseDto.currency.toCurrency());
    }
    return null;
  }
}

extension EventExt on Event {
  EventDTO toEventDTO() {
    if (this is GroupExpense) {
      final realId = id.startsWith(tempIdPrefix) ? "" : id;
      final expense = this as GroupExpense;
      return GroupExpenseDTO(
        id: realId,
        tempParticipants: expense.tempParticipants.map((e) => e.toDTO()),
        createdBy: createdBy.toDTO(),
        date: expense.dateState.toIso8601String(),
        receiptImageUrl: expense.receiptImageUrlState,
        timestamp: timestamp,
        description: expense.descriptionState,
        payee: expense.payerState.toDTO(),
        sharedExpenses: expense.sharedExpensesState.toDTO(),
        currency: expense.currencyState.toDTO(),
      );
    }
    return PaymentDTO(
        id: id,
        createdBy: createdBy.toDTO(),
        timestamp: timestamp,
        paidTo: (this as Payment).paidTo.toDTO(),
        paidBy: (this as Payment).paidBy.toDTO(),
        currency: (this as Payment).currency.toDTO(),
        amount: (this as Payment).amount);
  }
}
