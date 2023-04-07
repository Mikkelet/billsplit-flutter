import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualExpenseView extends StatefulWidget {
  final IndividualExpense individualExpense;

  const IndividualExpenseView(this.individualExpense, {Key? key})
      : super(key: key);

  @override
  State<IndividualExpenseView> createState() => _IndividualExpenseViewState();
}

class _IndividualExpenseViewState extends State<IndividualExpenseView> {
  final textController = TextEditingController();

  @override
  void initState() {
    textController.text = widget.individualExpense.expense.toString();
    textController.addListener(() {
      _onChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.individualExpense.person.name),
        TextField(
          keyboardType: TextInputType.number,
          controller: textController,
          decoration: InputDecoration(errorText: _errorText()),
          onChanged: (text) {
            context.read<AddExpenseBloc>().onExpensesUpdated();
          },
        ),
        Text(widget.individualExpense.expense.toString()),
      ],
    );
  }

  String? _errorText() {
    final text = textController.text;
    if (text.isEmpty) return "Enter a number";
    try {
      final number = num.parse(text);
      if (number < 0) return "Input must be positive";
      return null;
    } catch (e) {
      return "Invalid inp";
    }
  }

  void _onChange() {
    final text = textController.text;

    // prevents numbers starting with 0
    if (text.startsWith("0") && text.length > 1) {
      textController.text = text.replaceFirst("0", "");
      textController.selection =
          TextSelection.collapsed(offset: textController.text.length);
    }

    // input validation
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
      if (kDebugMode) {
        print(e);
      }
    }
    widget.individualExpense.expense = inputAsNumber;
  }
}
