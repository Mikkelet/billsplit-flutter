import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'shared_expense.dart';

class GroupExpense extends Event {
  final Person _payer;
  final String _description;
  final Iterable<SharedExpense> _sharedExpenses;
  final SyncState syncState;
  final Currency _currency;
  final List<Person> _tempParticipants;
  final String _receiptImageUrl;
  final DateTime _date;

  // modifiable values
  late Person payerState = _payer;
  late String receiptImageUrlState = _receiptImageUrl;
  late String descriptionState = _description;
  late List<SharedExpense> sharedExpensesState = _sharedExpenses.toList();
  late Currency currencyState = _currency;
  late DateTime dateState = _date;

  GroupExpense({
    required String id,
    required Person createdBy,
    required num timestamp,
    required String description,
    required Iterable<SharedExpense> sharedExpenses,
    required Person payer,
    required Currency currency,
    required Iterable<Person> tempParticipants,
    required String receiptImageUrl,
    required DateTime date,
    required this.syncState,
  })  : _payer = payer,
        _sharedExpenses = sharedExpenses,
        _description = description,
        _date = date,
        _receiptImageUrl = receiptImageUrl,
        _tempParticipants = tempParticipants.toList(),
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
                currency: currencyState.symbol,
                person: person,
                expense: sharedExpense.sharedExpenseDivided)))
        .flatMap()
        .map((e) => e.expense)
        .sum;
  }

  bool get isChanged {
    return _payer.uid != payerState.uid ||
        _description != descriptionState ||
        _currency != currencyState ||
        _date.millisecondsSinceEpoch != dateState.millisecondsSinceEpoch ||
        !sharedExpensesState.equals(_sharedExpenses.toList()) ||
        sharedExpensesState.any((element) => element.isChanged);
  }

  void resetChanges() {
    descriptionState = _description;
    payerState = _payer;
    sharedExpensesState = _sharedExpenses.toList();
    currencyState = _currency;
    dateState = _date;
  }

  GroupExpense.newExpense(Person user, Group group)
      : this(
            id: "",
            createdBy: user,
            description: "",
            sharedExpenses: [SharedExpense.newInstance(group.people)],
            syncState: SyncState.synced,
            payer: user,
            receiptImageUrl: "",
            tempParticipants: [],
            date: DateTime.now(),
            currency: Currency(symbol: group.defaultCurrencyState, rate: 1),
            timestamp: DateTime.now().millisecondsSinceEpoch);

  Iterable<Person> get tempParticipants => _tempParticipants;

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

  void addTempParticipant(String name, SharedExpense sharedExpense) {
    final uuid = const Uuid().v4();
    final person = Person(uid: "temp-$uuid", name: name);
    _tempParticipants.add(person);
    sharedExpense.addParticipant(person);
  }

  void removeTempParticipant(Person person) {
    _tempParticipants.remove(person);
  }

  String get dateString => DateFormat("MMMM d, yyyy").format(dateState);
}
