import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class SharedExpense {
  final num _expense;
  final Iterable<Person> _participants;
  final String _description;

  late final MutableState<num> expenseState = _expense.obs();
  late final MutableListState<Person> participantsState =
      _participants.obsList();
  late final MutableState<String> descriptionState = _description.obs();

  SharedExpense({
    required num expense,
    required Iterable<Person> participants,
    required String description,
  })  : _description = description,
        _expense = expense,
        _participants = participants;

  changeParticipantState(Person person, bool isParticipant) {
    if (isParticipant) {
      participantsState.add(person);
    } else {
      participantsState.remove(person);
    }
  }

  void addParticipant(Person person) {
    participantsState.add(person);
  }

  num get sharedExpenseDivided {
    try {
      return expenseState.value / participantsState.value.length;
    } catch (e) {
      return 0;
    }
  }

  SharedExpense.newInstance(Iterable<Person> participants)
      : this(participants: participants, description: "", expense: 0);

  Stream<bool> get isChangedStream {
    final Iterable<Stream<bool>> streams = [
      expenseState.stateStream.map((event) => event != _expense),
      descriptionState.stateStream.map((event) => event != _description),
      participantsState.stateStream.map((event) => !event.equals(_participants))
    ];
    return CombineLatestStream(
        streams, (values) => values.any((element) => element));
  }

  bool get isChanged {
    return _expense != expenseState.value ||
        _description != descriptionState.value ||
        !_participants.equals(participantsState.value);
  }

  @override
  bool operator ==(Object other) {
    if (other is! SharedExpense) return false;
    return hashCode == other.hashCode;
  }

  @override
  String toString() {
    return "SharedExpense(expense=$expenseState, participants=$participantsState, description=$descriptionState)";
  }

  @override
  int get hashCode => Object.hash(
      expenseState.value, participantsState.value, expenseState.value);

  void resetChanges() {
    expenseState.value = _expense;
    participantsState.value = _participants;
    descriptionState.value = _description;
  }

  void resetParticipants() {
    participantsState.value = _participants;
  }

  bool compareData(SharedExpense other) {
    return participantsState.value.equals(other.participantsState.value) &&
        expenseState.value == other.expenseState.value &&
        descriptionState.value == other.descriptionState.value;
  }
}
