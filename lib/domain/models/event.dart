import 'package:billsplit_flutter/domain/models/group.dart';
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

  Payment(
      {required String id,
      required Person createdBy,
      required num timestamp,
      required this.paidTo,
      required this.amount})
      : super(id, createdBy, timestamp);
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
    return individualExpenses.map((e) => e.expenseState).fold(sharedExpense.expenseState,
        (previousValue, element) => previousValue + element);
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

  GroupExpense.newExpense(Person user, Group group)
      : this(
            id: "",
            createdBy: user,
            description: "",
            individualExpenses:
                group.people.map((e) => IndividualExpense(person: e)).toList(),
            payer: user,
            sharedExpense: 0,
            timestamp: DateTime.now().millisecondsSinceEpoch);
}
