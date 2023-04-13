import 'package:billsplit_flutter/domain/models/person.dart';

class IndividualExpense {
  final Person person;
  final num _expense;
  final bool _isParticipant;

  // modifiable values
  late num expenseState = _expense;
  late bool isParticipantState = _isParticipant;

  IndividualExpense(
      {required this.person, num expense = 0, bool isParticipant = true})
      : _expense = expense,
        _isParticipant = isParticipant;

  IndividualExpense.sharedExpense(num sharedExpense)
      : this(
            person: Person("", "Shared", "https://i.imgur.com/S1HrKqU.png"),
            expense: sharedExpense);

  @override
  String toString() {
    return "IndividualExpense(person=$person, expense=$expenseState, isParticipant=$isParticipantState)";
  }
}
