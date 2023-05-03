import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescriptionTextField extends StatefulWidget {
  final String initialText;

  const DescriptionTextField({Key? key, required this.initialText})
      : super(key: key);

  @override
  State<DescriptionTextField> createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  late final textController = TextEditingController(text: widget.initialText);

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return TextField(
      controller: textController,
      textInputAction: TextInputAction.next,
      maxLines: 1,
      maxLength: 30,
      onChanged: (value) {
        cubit.groupExpense.descriptionState = value;
        cubit.onExpensesUpdated();
      },
      decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintText:
              "What is ${cubit.groupExpense.payerState.nameState} paying for?"),
    );
  }
}
