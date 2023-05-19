import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class ExpenseTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final void Function(num) onChange;
  final bool canBeZero;
  final bool autoFocus;
  final num? maxValue;
  final String prefix;

  const ExpenseTextField({
    Key? key,
    required this.textEditingController,
    required this.onChange,
    this.canBeZero = true,
    this.autoFocus = false,
    this.maxValue,
    this.prefix = "",
  }) : super(key: key);

  @override
  State<ExpenseTextField> createState() => _ExpenseTextFieldState();

  static const maxInput = 9999999.99; // max 7 chars + 2 decimals
}

class _ExpenseTextFieldState extends State<ExpenseTextField> {
  @override
  void initState() {
    widget.textEditingController.addListener(() {
      widget.onChange(parseInput);
      _onChange();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autoFocus,
      maxLength: 7,
      textAlign: TextAlign.end,
      maxLines: 1,
      controller: widget.textEditingController,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        isDense: true,
        hintText: "0",
        border: InputBorder.none,
        errorText: _errorText(),
        prefixStyle: const TextStyle(fontSize: 10),
        prefixText: widget.prefix.toUpperCase(),
        counterText: "",
        prefixIconConstraints: const BoxConstraints(),
        suffix: widget.maxValue != null
            ? TextButton(
                onPressed: isInputMaxValue() ? null : () => onMaxPressed(),
                child: const Text("max"))
            : null,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.done,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  void onMaxPressed() {
    text = widget.maxValue!.fmtTextField();
    widget.textEditingController.selection =
        TextSelection.collapsed(offset: text.length);
  }

  String? _errorText() {
    if (text.isEmpty) return "Enter a number";
    try {
      final number = num.parse(text);
      if (!widget.canBeZero && number == 0) return "Expense is 0";
      if (number < 0) return "Input < 0";
      return null;
    } catch (e) {
      return "Invalid input";
    }
  }

  num get parseInput {
    num inputAsNumber = 0;
    try {
      final input = num.parse(text);
      if (input < 0) {
        inputAsNumber = 0;
      } else if (input > ExpenseTextField.maxInput) {
        inputAsNumber = ExpenseTextField.maxInput;
      } else {
        inputAsNumber = input;
      }
    } catch (e) {
      print("$e: $inputAsNumber");
      inputAsNumber = 0;
    }
    return inputAsNumber;
  }

  bool isInputMaxValue() {
    if (widget.maxValue == null) return true;
    return parseInput.fmt2dec() == widget.maxValue!.fmt2dec();
  }

  bool isInputOverMaxValue() {
    if (widget.maxValue == null) return false;
    return parseInput > widget.maxValue! &&
        (parseInput.fmt2dec() != widget.maxValue!.fmt2dec() ||
            text.length > widget.maxValue!.fmt2dec().length);
  }

  void _onChange() {
    if (text == "0") {
      text = "";
      widget.textEditingController.selection =
          TextSelection.collapsed(offset: text.length);
    }
    if (isInputOverMaxValue()) {
      text = widget.maxValue!.fmtTextField();
      widget.textEditingController.selection =
          TextSelection.collapsed(offset: text.length);
    }
    if (text.contains(",")) {
      text = text.replaceAll(",", ".");
      widget.textEditingController.selection =
          TextSelection.collapsed(offset: text.length);
    }
  }

  String get text => widget.textEditingController.text;

  set text(String text) {
    widget.textEditingController.text = text;
  }
}
