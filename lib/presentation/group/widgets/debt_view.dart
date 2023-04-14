import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class DebtView extends StatelessWidget {
  final Pair<Person, num> debt;

  const DebtView({Key? key, required this.debt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "";
    Color color = Colors.black;
    if (debt.second > 0) {
      text = "You owe \$${debt.second.fmt2dec()} to ${debt.first.nameState}";
      color = Colors.redAccent;
    }
    if (debt.second < 0) {
      text =
          "${debt.first.nameState} owes you \$${debt.second.abs().fmt2dec()}";
      color = Colors.greenAccent;
    }
    return RoundedListItem(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(color: color)),
        MaterialButton(
          onPressed: () {},
          child: const Text("Pay"),
        )
      ],
    ));
  }
}
