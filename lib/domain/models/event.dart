import 'dart:math';

import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

abstract class Event {
  final String id;
  final Person createdBy;
  final num timestamp;

  Event(this.id, this.createdBy, this.timestamp);
}

class GroupExpense extends Event {
  final Person payer;
  final num sharedExpense;
  final List<IndividualExpense> individualExpenses;

  GroupExpense(
      {required String id,
      required Person createdBy,
      required num timestamp,
      required this.payer,
      required this.sharedExpense,
      required this.individualExpenses})
      : super(id, createdBy, timestamp);

  num getTotal() {
    final sumOfExpenses = individualExpenses
        .map((e) => e.expense)
        .fold(0.0, (previousValue, element) => previousValue + element);

    return sumOfExpenses + sharedExpense;
  }

  GroupExpense.dummy(num seed)
      : this(
            id: "GE$seed",
            createdBy: Person.dummy(seed),
            individualExpenses: [],
            payer: Person.dummy(seed),
            sharedExpense: 0,
            timestamp: 0);
}
