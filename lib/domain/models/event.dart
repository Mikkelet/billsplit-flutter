import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

abstract class Event {
  final String id;
  final Person createdBy;
  final num timestamp;

  Event(this.id, this.createdBy, this.timestamp);
}

class Payment extends Event {
  final Person paidTo;
  final num amount;

  Payment(super.id, super.createdBy, super.timestamp, this.paidTo, this.amount);
}

class GroupExpense extends Event {
  final Person payer;
  final IndividualExpense sharedExpense;
  final List<IndividualExpense> individualExpenses;
  final String description;

  GroupExpense(
      {required String id,
      required Person createdBy,
      required num timestamp,
      required this.description,
      required this.payer,
      required num sharedExpense,
      required this.individualExpenses})
      : sharedExpense = IndividualExpense.sharedExpense(sharedExpense),
        super(id, createdBy, timestamp);

  num getTotal() {
    final sumOfExpenses = individualExpenses
        .map((e) => e.expense)
        .fold(0.0, (previousValue, element) => previousValue + element);

    return sumOfExpenses + sharedExpense.expense;
  }

  GroupExpense.dummy(num seed)
      : this(
            id: "GE$seed",
            createdBy: Person.dummy(seed),
            description: "",
            individualExpenses: [],
            payer: Person.dummy(seed),
            sharedExpense: 0,
            timestamp: 0);

  GroupExpense.newExpense()
      : this(
            id: "",
            createdBy: Person.dummy(0),
            description: "",
            individualExpenses: [],
            payer: Person.dummy(0),
            sharedExpense: 0,
            timestamp: 0);
}
