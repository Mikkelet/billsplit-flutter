
import 'package:flutter/material.dart';

class ExpenseTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function(num) onChange;
  final bool canBeZero;
  final bool autoFocus;

  ExpenseTextField({
    Key? key,
    required this.textEditingController,
    required this.onChange,
    this.canBeZero = true,
    this.autoFocus = false,
  }) : super(key: key) {
    textEditingController.addListener(() {
      onChange(_parseInputToNum());
      _onChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      maxLength: 7,
      textAlign: TextAlign.end,
      maxLines: 1,
      controller: textEditingController,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        isDense: true,
        hintText: "0",
        border: InputBorder.none,
        errorText: _errorText(),
        prefixIcon: const Icon(Icons.attach_money_outlined),
        counterText: "",
        prefixIconConstraints: const BoxConstraints(),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.done,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  String? _errorText() {
    final text = textEditingController.text;
    if (text.isEmpty) return "Enter a number";
    try {
      final number = num.parse(text);
      if (!canBeZero && number == 0) return "Expense is 0";
      if (number < 0) return "Input < 0";
      return null;
    } catch (e) {
      return "Invalid input";
    }
  }

  num _parseInputToNum() {
    final text = textEditingController.text;
    num inputAsNumber = 0;
    try {
      final input = num.parse(text);
      if (input < 0) {
        inputAsNumber = 0;
      } else if (input > MAX_INPUT) {
        inputAsNumber = MAX_INPUT;
      } else {
        inputAsNumber = input;
      }
    } catch (e) {
      inputAsNumber = 0;
      print(e);
    }
    return inputAsNumber;
  }

  void _onChange() {
    final text = textEditingController.text;

    if (text.startsWith("0")) {
      textEditingController.text = "";
      textEditingController.selection =
          TextSelection.collapsed(offset: textEditingController.text.length);
    }
  }

  static const MAX_INPUT = 9999999;
}
