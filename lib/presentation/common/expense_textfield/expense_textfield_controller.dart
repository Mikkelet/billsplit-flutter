
import 'package:flutter/material.dart';

class ExpenseTextFieldController extends TextEditingController {
  ExpenseTextFieldController({String? text}) : super(text: text);

  String? errorText;

  bool get hasError {
    return errorText != null;
  }
}
