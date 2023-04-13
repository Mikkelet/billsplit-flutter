import 'package:billsplit_flutter/domain/models/person.dart';

class IndividualExpense {
  final Person person;
  final num _expense;
  final bool isParticipant;

  // modifiable values
  late num expenseState = _expense;

  IndividualExpense(
      {required this.person, num expense = 0, this.isParticipant = false})
      : _expense = expense;

  IndividualExpense.sharedExpense(num sharedExpense)
      : this(person: Person("", "Shared", ""), expense: sharedExpense);

  @override
  String toString() {
    return "IndividualExpense(person=$person, expense=$expenseState, isParticipant=$isParticipant)";
  }
}
