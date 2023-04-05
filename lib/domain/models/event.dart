import 'package:billsplit_flutter/domain/models/expense_holder.dart';
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

  GroupExpense.dummy(num seed)
      : this(
            id: "GE$seed",
            createdBy: Person.dummy(seed),
            individualExpenses: [],
            payer: Person.dummy(seed),
            sharedExpense: 0,
            timestamp: 0);
}
