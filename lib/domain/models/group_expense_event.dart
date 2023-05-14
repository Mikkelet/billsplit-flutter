import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:collection/collection.dart';

import 'shared_expense.dart';

class GroupExpense extends Event {
  final Person _payer;
  final String _description;
  final Iterable<SharedExpense> _sharedExpenses;
  final SyncState syncState;
  final Currency _currency;

  // modifiable values
  late Person payerState = _payer;
  late String descriptionState = _description;
  late List<SharedExpense> sharedExpensesState = _sharedExpenses.toList();
  late Currency currencyState = _currency;

  GroupExpense({
    required String id,
    required Person createdBy,
    required num timestamp,
    required String description,
    required Iterable<SharedExpense> sharedExpenses,
    required Person payer,
    required Currency currency,
    required this.syncState,
  })  : _payer = payer,
        _sharedExpenses = sharedExpenses,
        _description = description,
        _currency = currency,
        super(id, createdBy, timestamp);

  num get total {
    return sharedExpensesState.map((e) => e.expenseState).sum;
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
    return _payer.uid != payerState.uid ||
        _description != descriptionState ||
        !sharedExpensesState.equals(_sharedExpenses.toList()) ||
        sharedExpensesState.any((element) => element.isChanged);
  }

  void resetChanges() {
    descriptionState = _description;
    payerState = _payer;
    sharedExpensesState = _sharedExpenses.toList();
  }

  GroupExpense.dummy(num seed)
      : this(
            id: "GE$seed",
            createdBy: Person.dummy(seed),
            description: "",
            sharedExpenses: [],
            syncState: SyncState.synced,
            payer: Person.dummy(seed),
            currency: Currency(symbol: "usd", rate: 1),
            timestamp: 0);

  GroupExpense.newExpense(Person user, Group group)
      : this(
            id: "",
            createdBy: user,
            description: "",
            sharedExpenses: [SharedExpense.newInstance(group.people)],
            syncState: SyncState.synced,
            payer: user,
            currency: Currency(symbol: "usd", rate: 1),
            timestamp: DateTime.now().millisecondsSinceEpoch);

  @override
  String toString() {
    return "GroupExpense(id=$id, createdBy=$createdBy, description=$_description, sharedExpenses=$sharedExpensesState, payer=$payerState)";
  }

  SharedExpense addNewSharedExpense(
      {required Iterable<Person> withParticipants}) {
    final Iterable<Person> currentParticipants = [
      ...sharedExpensesState.map((e) => e.participantsState).toList()
    ].flatMap().toSet();
    final se = SharedExpense.newInstance(currentParticipants);
    se.participantsState = withParticipants.toList();
    sharedExpensesState.add(se);
    return se;
  }

  void removeSharedExpense(SharedExpense sharedExpense) {
    sharedExpensesState.remove(sharedExpense);
  }
}
