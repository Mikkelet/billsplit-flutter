import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';

void main() {
  final groupExpense = GroupExpense(
    id: "id",
    createdBy: Person.dummy(2),
    timestamp: 2,
    surcharges: [],
    description: "description",
    sharedExpenses: [
      SharedExpense(expense: 5, participants: [Person.dummy(2)], description: ""),
      SharedExpense(expense: 5, participants: [Person.dummy(2)], description: ""),
      SharedExpense(expense: 5, participants: [Person.dummy(2)], description: ""),
      SharedExpense(expense: 5, participants: [Person.dummy(2)], description: ""),
    ],
    payer: Person.dummy(2),
    currency: Currency.usd(),
    tempParticipants: [Person.dummy(3)],
    receiptImageUrl: "",
    date: "DateTime.now()",
    syncState: SyncState.synced,
  );
}
