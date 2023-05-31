import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class ExpenseTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final void Function(num) onChange;
  final bool canBeZero;
  final bool autoFocus;
  final num? maxValue;
  final String prefix;
  final TextAlign textAlign;
  final double? fontSize;
  /// Toggle whether any error should be shown as text or, alternatively, as color the hint-text red.
  final bool showErrorText;
  /// Toggle to show input validation error. Will override [showErrorText].
  final bool showError;

  const ExpenseTextField({
    Key? key,
    required this.textEditingController,
    required this.onChange,
    this.canBeZero = true,
    this.autoFocus = false,
    this.showErrorText = true,
    this.showError = true,
    this.fontSize,
    this.textAlign = TextAlign.right,
    this.maxValue,
    this.prefix = "",
  }) : super(key: key);

  @override
  State<ExpenseTextField> createState() => _ExpenseTextFieldState();

  static const maxInput = 9999999.99; // max 7 chars + 2 decimals
}

class _ExpenseTextFieldState extends SafeState<ExpenseTextField> {
  final focusNode = FocusNode();

  @override
  void initState() {
    widget.textEditingController.addListener(() {
      widget.onChange(parseInput);
      _onChange();
      updateState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autoFocus,
      maxLength: 7,
      textAlign: widget.textAlign,
      maxLines: 1,
      focusNode: focusNode,
      controller: widget.textEditingController,
      style: builder(() {
        if (widget.fontSize != null) {
          return SplitsbyTextTheme.textFieldStyle(context)
              .copyWith(fontSize: widget.fontSize);
        } else {
          return SplitsbyTextTheme.textFieldStyle(context);
        }
      }),
      decoration: InputDecoration(
        isDense: true,
        hintText: "${widget.prefix} 0.00",
        errorStyle: SplitsbyTextTheme.textFieldErrorText(context),
        border: InputBorder.none,
        errorText: builder(() {
          if (!widget.showErrorText) return null;
          return _errorText();
        }),
        counterText: "",
        hintStyle: _getHintStyle(context),
        prefixIconConstraints: const BoxConstraints(),
        suffix: widget.maxValue != null
            ? TextButton(
                onPressed: onMaxPressed,
                child: Builder(builder: (context) {
                  Color textColor = Colors.grey;
                  if (!isInputMaxValue()) {
                    textColor = Theme.of(context).colorScheme.onSurface;
                  }
                  return Text("max", style: TextStyle(color: textColor));
                }))
            : null,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.done,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  TextStyle _getHintStyle(BuildContext context) {
    final TextStyle baseHintStyle = builder(() {
      if (!widget.showErrorText && _errorText() != null) {
        return SplitsbyTextTheme.textFieldErrorText(context);
      }
      return SplitsbyTextTheme.textFieldHintStyle(context);
    });

    if (widget.fontSize != null) {
      return baseHintStyle.copyWith(fontSize: widget.fontSize);
    } else {
      return baseHintStyle;
    }
  }

  void onMaxPressed() {
    text = widget.maxValue!.fmtTextField();
    widget.textEditingController.selection =
        TextSelection.collapsed(offset: text.length);
  }

  String? _errorText() {
    if (text.isEmpty) {
      if (focusNode.hasFocus) {
        return null;
      } else {
        return "Enter a number";
      }
    }
    try {
      final number = num.parse(text);
      if (!widget.canBeZero && number == 0) return "Expense is 0";
      if (number < 0) return "Input < 0";
      return null;
    } catch (e) {
      return "Invalid input";
    }
  }

  double get parseInput {
    double inputAsNumber = 0.00;
    try {
      final input = double.parse(text);
      if (input < 0) {
        inputAsNumber = 0;
      } else if (input > ExpenseTextField.maxInput) {
        inputAsNumber = ExpenseTextField.maxInput;
      } else {
        inputAsNumber = input;
      }
    } catch (e) {
      print("${e.runtimeType}: $inputAsNumber");
      inputAsNumber = 0.00;
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
    if (text.isNotEmpty && parseInput == 0) {
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
