import 'package:billsplit_flutter/domain/models/person.dart';

class IndividualExpense {
  final Person person;
  final num expense;
  final String currency;

  IndividualExpense(
      {required this.currency, required this.person, this.expense = 0});

  @override
  String toString() {
    return "IndividualExpense(person=$person, expense=$expense)";
  }

  @override
  bool operator ==(Object other) {
    if (other is! IndividualExpense) return false;
    return person == other.person;
  }

  @override
  int get hashCode => person.uid.hashCode;
}
