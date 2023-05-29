import 'dart:math';

import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';

class SharedExpenseDescriptionView extends StatefulWidget {
  final SharedExpense sharedExpense;
  final bool showIcon;
  final bool alignRight;
  final bool autoFocus;

  const SharedExpenseDescriptionView(
      {Key? key,
      required this.sharedExpense,
      this.showIcon = false,
      this.alignRight = false,
      this.autoFocus = false})
      : super(key: key);

  @override
  State<SharedExpenseDescriptionView> createState() =>
      _SharedExpenseDescriptionViewState();
}

class _SharedExpenseDescriptionViewState
    extends SafeState<SharedExpenseDescriptionView> {
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
      textInputAction: TextInputAction.next,
      textAlign: widget.alignRight ? TextAlign.end : TextAlign.start,
      autofocus: widget.autoFocus,
      maxLines: 1,
      maxLength: 20,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        counterText: "",
        prefixIcon: widget.showIcon
            ? const Padding(
                padding: EdgeInsets.only(right: 8), child: Icon(Icons.edit))
            : null,
        isDense: true,
        prefixIconConstraints: const BoxConstraints(),
        border: InputBorder.none,
        hintText: "ex. ${randomMenuItems[randomNumber]}",
      ),
    );
  }
}
