import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:collection/collection.dart';

import 'shared_expense.dart';

class GroupExpense extends Event {
  final Person _payer;
  final Iterable<IndividualExpense> individualExpenses;
  final String _description;
  final Iterable<SharedExpense> _sharedExpenses;

  // modifiable values
  late Person payerState = _payer;
  late String descriptionState = _description;
  late List<SharedExpense> sharedExpensesState = _sharedExpenses.toList();

  GroupExpense(
      {required String id,
      required Person createdBy,
      required num timestamp,
      required String description,
      required Iterable<SharedExpense> sharedExpenses,
      required Person payer,
      required this.individualExpenses})
      : _payer = payer,
        _sharedExpenses = sharedExpenses,
        _description = description,
        super(id, createdBy, timestamp);

  num get total {
    return individualExpenses.map((e) => e.expenseState).sum +
        sharedExpensesState.map((e) => e.expenseState).sum;
  }

  num getSharedExpensesForPerson(Person person) {
    return sharedExpensesState
        .map((sharedExpense) => sharedExpense.participantsState
            .where((participant) => participant.uid == person.uid)
            .map((person) => IndividualExpense(
                person: person, expense: sharedExpense.sharedExpenseDivided)))
        .flatMap()
        .map((e) => e.expenseState)
        .sum;
  }

  bool get isChanged {
    return _payer.uid == payerState.uid &&
        _description == descriptionState &&
        individualExpenses.every((element) => element.isChanged) &&
        sharedExpensesState.every((element) => element.isChanged) &&
        sharedExpensesState.equals(_sharedExpenses.toList());
  }

  GroupExpense.dummy(num seed)
      : this(
            id: "GE$seed",
            createdBy: Person.dummy(seed),
            description: "",
            individualExpenses: [],
            sharedExpenses: [],
            payer: Person.dummy(seed),
            timestamp: 0);

  GroupExpense.newExpense(Person user, Group group)
      : this(
            id: "",
            createdBy: user,
            description: "",
            individualExpenses:
                group.people.map((e) => IndividualExpense(person: e)).toList(),
            sharedExpenses: [SharedExpense.newInstance(group.people)],
            payer: user,
            timestamp: DateTime.now().millisecondsSinceEpoch);

  @override
  String toString() {
    return "GroupExpense(id=$id, createdBy=$createdBy, description=$_description, sharedExpenses=$sharedExpensesState, payer=$payerState)";
  }

  void addNewSharedExpense(Iterable<Person> people) {
    sharedExpensesState.add(SharedExpense.newInstance(people));
  }

  void removeSharedExpense(SharedExpense sharedExpense) {
    sharedExpensesState.remove(sharedExpense);
  }
}
