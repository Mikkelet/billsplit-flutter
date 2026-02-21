import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/surcharge.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'shared_expense.dart';

part '../../_generated/domain/models/group_expense_event.freezed.dart';

@freezed
abstract class GroupExpense extends Event with _$GroupExpense {
  const factory GroupExpense({
    @Default("") String id,
    @Default(Person()) Person payer,
    @Default(Person()) Person createdBy,
    @Default("") String description,
    @Default([]) List<SharedExpense> sharedExpenses,
    @Default(SyncState.pending) SyncState syncState,
    @Default(Currency.usdValue) Currency currency,
    @Default([]) List<Person> tempParticipants,
    @Default("") String receiptImageUrl,
    @Default("") String date,
    @Default(0) int timestamp,
    @Default([]) List<Surcharge> surcharges,
  }) = _GroupExpense;

  const GroupExpense._() : super("", const Person(), 0);

  double get total => sharedExpenses.map((e) => e.expense).sum.toDouble();

  DateTime get dateTime => DateTime.parse(date);

  num getSharedExpensesForPerson(Person person) {
    return sharedExpenses
        .map(
          (sharedExpense) => sharedExpense.participants
              .where((participant) => participant.uid == person.uid)
              .map(
                (person) => IndividualExpense(
                  currency: currency.symbol,
                  person: person,
                  expense: sharedExpense.sharedExpenseDivided,
                ),
              ),
        )
        .flatMap()
        .map((e) => e.expense)
        .sum;
  }
}
