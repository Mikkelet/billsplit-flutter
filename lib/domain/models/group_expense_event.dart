import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import 'shared_expense.dart';

class GroupExpense extends Event {
  final Person _payer;
  final String _description;
  final Iterable<SharedExpense> _sharedExpenses;
  final SyncState syncState;
  final Currency _currency;
  final Iterable<Person> _tempParticipants;
  final String _receiptImageUrl;
  final DateTime _date;

  // modifiable values
  late final MutableState<Person> payerState = _payer.obs();
  late final MutableState<String> receiptImageUrlState = _receiptImageUrl.obs();
  late final MutableState<String> descriptionState = _description.obs();
  late final MutableListState<SharedExpense> sharedExpensesState =
      _sharedExpenses.obsList();
  late final MutableState<Currency> currencyState = _currency.obs();
  late final MutableState<DateTime> dateState = _date.obs();
  late final MutableListState<Person> tempParticipantsState =
      _tempParticipants.obsList();

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

  Stream<num> get totalStream {
    final streams = sharedExpensesState.value
        .map((event) => event.expenseState.stateStream);
    return CombineLatestStream(streams, (values) => values.sum);
  }

  num get total {
    return sharedExpensesState.value.map((e) => e.expenseState.value).sum;
  }

  num getSharedExpensesForPerson(Person person) {
    return sharedExpensesState.value
        .map((sharedExpense) => sharedExpense.participantsState.value
        .where((participant) => participant.uid == person.uid)
        .map((person) => IndividualExpense(
        currency: currencyState.value.symbol,
        person: person,
        expense: sharedExpense.sharedExpenseDivided)))
        .flatMap()
        .map((e) => e.expense)
        .sum;
  }

  bool get isChanged {
    return _payer.uid != payerState.value.uid ||
        _description != descriptionState.value ||
        _currency != currencyState.value ||
        _date.millisecondsSinceEpoch != dateState.value.millisecondsSinceEpoch ||
        !_sharedExpenses.toList().equals(sharedExpensesState.value.toList()) || // TODO
        sharedExpensesState.value.any((element) => element.isChanged);
  }

  Stream<bool> get isChangeStream {
    final sharedExpensesStreams =
        sharedExpensesState.value.map((element) => element.isChangedStream);

    final streams = [
      payerState.stateStream.map((payer) => payer.uid != _payer.uid),
      descriptionState.stateStream
          .map((description) => description != _description),
      currencyState.stateStream.map((event) => event != _currency),
      tempParticipantsState.stateStream
          .map((event) => !event.equals(_tempParticipants)),
      dateState.stateStream.map((event) =>
          event.millisecondsSinceEpoch != _date.millisecondsSinceEpoch),
      sharedExpensesState.stateStream
          .map((event) => !event.toList().equals(_sharedExpenses.toList())),
      ...sharedExpensesStreams,
    ];
    return CombineLatestStream(
        streams,
        (values) => values.any((element) {
              return element;
            }));
  }

  void resetChanges() {
    descriptionState.value = _description;
    payerState.value = _payer;
    sharedExpensesState.value = _sharedExpenses;
    currencyState.value = _currency;
    dateState.value = _date;
    tempParticipantsState.value = _tempParticipants;
    for (var element in sharedExpensesState.value) {
      element.resetChanges();
    }
  }

  GroupExpense.newExpense(Person user, Group group)
      : this(
          id: "",
          createdBy: user,
          description: "",
          sharedExpenses: [SharedExpense.newInstance(group.peopleState.value)],
          syncState: SyncState.synced,
          payer: user,
          receiptImageUrl: "",
          tempParticipants: [],
          date: DateTime.now(),
          currency: Currency(symbol: group.defaultCurrencyState.value, rate: 1),
          timestamp: DateTime.now().millisecondsSinceEpoch,
        );

  @override
  String toString() {
    return "GroupExpense(id=$id, createdBy=$createdBy, description=$_description, sharedExpenses=$sharedExpensesState, payer=$payerState)";
  }

  SharedExpense addNewSharedExpense(
      {required Iterable<Person> withParticipants}) {
    final Iterable<Person> currentParticipants = [
      ...sharedExpensesState.value.map((e) => e.participantsState.value)
    ].flatMap().toSet();
    final se = SharedExpense.newInstance(currentParticipants);
    se.participantsState.value = withParticipants.toList();
    sharedExpensesState.add(se);
    return se;
  }

  void removeSharedExpense(SharedExpense sharedExpense) {
    sharedExpensesState.remove(sharedExpense);
  }

  void addTempParticipant(String name, SharedExpense sharedExpense) {
    final uuid = const Uuid().v4();
    final person = Person(uid: "temp-$uuid", name: name);
    tempParticipantsState.add(person);
    sharedExpense.addParticipant(person);
  }

  void removeTempParticipant(Person person) {
    tempParticipantsState.remove(person);
  }

  String get dateString => DateFormat("MMMM d, yyyy").format(dateState.value);
}
