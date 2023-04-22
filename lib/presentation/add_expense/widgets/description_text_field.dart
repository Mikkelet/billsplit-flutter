import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return TextField(
      onChanged: (value){
        cubit.groupExpense.descriptionState = value;
      },
      decoration: const InputDecoration(
          border: InputBorder.none, hintText: "What did you pay for?"),
    );
  }
}
