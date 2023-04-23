import 'package:billsplit_flutter/domain/models/person.dart';

class SharedExpense {
  final String id;
  final num _expense;
  final List<Person> _participants;
  final String _description;

  late num expenseState = _expense;
  late List<Person> participantsState = _participants;
  late String descriptionState = _description;

  SharedExpense(
      {required this.id,
      required num expense,
      required List<Person> participants,
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

  SharedExpense.newInstance(List<Person> participants)
      : this(id: "", participants: participants, description: "", expense: 0);
}
