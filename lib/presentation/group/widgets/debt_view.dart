import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:flutter/material.dart';

class DebtView extends StatelessWidget {
  final Pair<Person, num> debt;

  const DebtView({Key? key, required this.debt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (debt.second > 0) {
      return Text("You owe \$${debt.second} to ${debt.first.nameState}");
    }
    if (debt.second < 0) {
      return Text("${debt.first.nameState} owes you \$${debt.second}");
    }
    return Container();
  }
}
