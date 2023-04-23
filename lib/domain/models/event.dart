import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:collection/collection.dart';

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

  @override
  String toString() {
    return "Payment(id=$id, createdBy=$createdBy, paidTo=$paidTo, amount=$amount)";
  }
}

class GroupExpense extends Event {
  final Person _payer;
  final IndividualExpense sharedExpense;
  final List<IndividualExpense> individualExpenses;
  final String _description;

  // modifiable values
  late Person payerState = _payer;
  late String descriptionState = _description;

  late List<SharedExpense> sharedExpenses = [
    SharedExpense.newInstance(individualExpenses.map((e) => e.person).toList())
  ];

  GroupExpense(
      {required String id,
      required Person createdBy,
      required num timestamp,
      required String description,
      required Person payer,
      required num sharedExpense,
      required this.individualExpenses})
      : sharedExpense = IndividualExpense.sharedExpense(sharedExpense),
        _payer = payer,
        _description = description,
        super(id, createdBy, timestamp);

  num get total {
    return individualExpenses.map((e) => e.expenseState).sum +
        sharedExpenses.map((e) => e.expenseState).sum;
  }

  num getSharedExpensesForPerson(Person person) {
    return sharedExpenses
        .map((sharedExpense) => sharedExpense.participantsState
            .where((participant) => participant.uid == person.uid)
            .map((person) => IndividualExpense(
                person: person, expense: sharedExpense.sharedExpenseDivided)))
        .flatMap()
        .map((e) => e.expenseState)
        .sum;
  }

  num get sharedExpensePerParticipant {
    try {
      final sharedExpensesPerPerson = sharedExpenses.map((sharedExpense) =>
          sharedExpense.participantsState.map((person) => IndividualExpense(
              person: person, expense: sharedExpense.sharedExpenseDivided)));

      final numOfParticipants =
          [...individualExpenses, ...sharedExpensesPerPerson].length;
      return sharedExpense.expenseState / numOfParticipants;
    } catch (e) {
      print("qqq e=$e");
      return 0;
    }
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

  @override
  String toString() {
    return "GroupExpense(id=$id, createdBy=$createdBy, description=$_description, sharedExpense=${sharedExpense.expenseState}, payer=$payerState)";
  }

  void addNewSharedExpense() {
    sharedExpenses.add(SharedExpense.newInstance(
        individualExpenses.map((e) => e.person).toList()));
  }

  void removeSharedExpense(SharedExpense sharedExpense) {
    sharedExpenses.remove(sharedExpense);
  }
}
