import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/expense_textfield_controller.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class ExpenseTextField extends StatefulWidget {
  final ExpenseTextFieldController textEditingController;
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

  ExpenseTextField({
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
  static const minInput = -9999999.99; // max 7 chars + 2 decimals
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
      maxLength: _getTextLength(),
      textAlign: widget.textAlign,
      maxLines: 1,
      focusNode: focusNode,
      controller: widget.textEditingController,
      style: _getStyle(),
      decoration: InputDecoration(
        isDense: true,
        hintText: "${widget.prefix} 0.00",
        border: InputBorder.none,
        counterText: "",
        hintStyle: _getHintStyle(context),
        prefixIconConstraints: const BoxConstraints(),
        suffix: _getSuffix(),
      ),
      keyboardType:
          const TextInputType.numberWithOptions(decimal: true, signed: true),
      textInputAction: TextInputAction.done,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  TextStyle _getHintStyle(BuildContext context) {
    final TextStyle baseHintStyle = builder(() {
      if (!widget.showErrorText && widget.textEditingController.hasError) {
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
      if (!widget.canBeZero && number <= 0) return "Must be positive";
      return null;
    } catch (e) {
      return "Invalid input";
    }
  }

  double get parseInput {
    double inputAsNumber = 0;
    if (text.isEmpty) return 0;
    try {
      final input = double.parse(text);
      if (!widget.canBeZero && input <= 0) {
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
            text.length > widget.maxValue!.fmtTextField().length);
  }

  void _onChange() {
    widget.textEditingController.errorText = _errorText();
    if (text.isNotEmpty && text == 0.fmtTextField()) {
      text = "";
    }
    if (text.startsWith("0")) {
      if (text.length == 1) {
        text = "";
      }
    }
    if (isInputOverMaxValue()) {
      text = widget.maxValue!.fmtTextField();
    }
    if (text.contains(",")) {
      text = text.replaceAll(",", ".");
    }
  }

  String get text => widget.textEditingController.text;

  set text(String text) {
    widget.textEditingController.text = text;
    widget.textEditingController.selection =
        TextSelection.collapsed(offset: text.length);
  }

  int _getTextLength() {
    if (parseInput < 0) {
      return 8;
    } else {
      return 7;
    }
  }

  Widget? _getSuffix() {
    if (widget.maxValue == null) {
      return null;
    }
    return TextButton(
      onPressed: onMaxPressed,
      child: Builder(
        builder: (context) {
          Color textColor = Colors.grey;
          if (!isInputMaxValue()) {
            textColor = Theme.of(context).colorScheme.onSurface;
          }
          return Text("max", style: TextStyle(color: textColor));
        },
      ),
    );
  }

  TextStyle _getStyle() {
    TextStyle baseStyle = SplitsbyTextTheme.textFieldStyle(context);
    if (widget.showError && widget.textEditingController.hasError) {
      baseStyle = SplitsbyTextTheme.textFieldErrorText(context);
    }
    if (widget.fontSize != null) {
      baseStyle = baseStyle.copyWith(fontSize: widget.fontSize);
    }
    return baseStyle;
  }
}
