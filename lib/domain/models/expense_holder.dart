
import 'package:billsplit_flutter/domain/models/person.dart';

class IndividualExpense {
  final Person person;
  num expense;
  bool isParticipant;

  IndividualExpense(
      {required this.person, this.expense = 0, this.isParticipant = false});

  @override
  String toString() {
    return "IndividualExpense(person=$person, expense=$expense, isParticipant=$isParticipant)";
  }
}
