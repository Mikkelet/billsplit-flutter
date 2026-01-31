
import 'package:flutter/material.dart';

class ExpenseTextFieldController extends TextEditingController {
  ExpenseTextFieldController({super.text});

  String? errorText;

  bool get hasError {
    return errorText != null;
  }
}
