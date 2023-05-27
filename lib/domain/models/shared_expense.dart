import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

class SharedExpense {
  final num _expense;
  final Iterable<Person> _participants;
  final String _description;
  final String keyId = UniqueKey().toString();

  late num expenseState = _expense;
  late List<Person> participantsState = _participants.toList();
  late String descriptionState = _description;

  SharedExpense(
      {required num expense,
      required Iterable<Person> participants,
      required String description})
      : _description = description,
        _expense = expense,
        _participants = participants;

  changeParticipantState(Person person, bool isParticipant) {
    if (isParticipant) {
      participantsState.add(person);
    } else {
      participantsState.remove(person);
    }
  }

  num get sharedExpenseDivided {
    try {
      return expenseState / participantsState.length;
    } catch (e) {
      return 0;
    }
  }

  SharedExpense.newInstance(Iterable<Person> participants)
      : this(participants: participants, description: "", expense: 0);

  bool get isChanged {
    return _expense != expenseState ||
        _description != descriptionState ||
        !_participants.toList().equals(participantsState);
  }

  @override
  bool operator ==(Object other) {
    if (other is! SharedExpense) return false;
    return descriptionState == other.descriptionState &&
        participantsState.equals(other.participantsState) &&
        expenseState == other.expenseState;
  }

  @override
  String toString() {
    return "SharedExpense(expense=$expenseState, participants=$participantsState, description=$descriptionState)";
  }
}
