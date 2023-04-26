import 'dart:math';

import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:flutter/material.dart';

class SharedExpenseDescriptionView extends StatefulWidget {
  final SharedExpense sharedExpense;
  final bool showIcon;
  final bool alignRight;

  const SharedExpenseDescriptionView(
      {Key? key,
      required this.sharedExpense,
      this.showIcon = false,
      this.alignRight = false})
      : super(key: key);

  @override
  State<SharedExpenseDescriptionView> createState() =>
      _SharedExpenseDescriptionViewState();
}

class _SharedExpenseDescriptionViewState
    extends State<SharedExpenseDescriptionView> {
  late final textController =
      TextEditingController(text: widget.sharedExpense.descriptionState);

  static const randomMenuItems = [
    "Burger",
    "Fries",
    "Wine",
    "Soda",
    "Chicken nuggets"
  ];
  final randomNumber = Random().nextInt(randomMenuItems.length);

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onChanged: (value) {
        widget.sharedExpense.descriptionState = value;
      },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textAlign: widget.alignRight ? TextAlign.end : TextAlign.start,
      decoration: InputDecoration(
        prefixIcon: const Padding(
            padding: EdgeInsets.only(right: 8), child: Icon(Icons.edit)),
        isDense: true,
        prefixIconConstraints: const BoxConstraints(),
        border: InputBorder.none,
        hintText: "fx. ${randomMenuItems[randomNumber]}",
      ),
    );
  }
}
