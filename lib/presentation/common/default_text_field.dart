import 'package:flutter/material.dart';

class ExpenseTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function(num) onChange;

  ExpenseTextField(
      {Key? key,
      required this.textEditingController,
      required this.onChange})
      : super(key: key) {
    textEditingController.addListener(() {
      onChange(_parseInputToNum());
      _onChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,

      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(4),
          isDense: true,
          border: InputBorder.none,
          errorText: _errorText(), icon: const Icon(Icons.attach_money)),
      keyboardType: TextInputType.number,
    );
  }

  String? _errorText() {
    final text = textEditingController.text;
    if (text.isEmpty) return "Enter a number";
    try {
      final number = num.parse(text);
      if (number < 0) return "Input must be positive";
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

    // prevents numbers starting with 0
    if (text.isEmpty) {
      textEditingController.text = "0";
      textEditingController.selection =
          TextSelection.collapsed(offset: textEditingController.text.length);
    } else if (text.startsWith("0") && text.length > 1) {
      textEditingController.text = text.replaceFirst("0", "");
      textEditingController.selection =
          TextSelection.collapsed(offset: textEditingController.text.length);
    }
  }
}
