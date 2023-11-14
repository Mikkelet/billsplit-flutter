import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerView extends StatefulWidget {
  const DatePickerView({super.key});

  @override
  State<DatePickerView> createState() => _DatePickerViewState();
}

class _DatePickerViewState extends State<DatePickerView> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final now = DateTime.now();
    return ClickableListItem(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 64,
      onClick: () async {
        final response = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: now.copyWith(year: now.year - 5),
          lastDate: now,
        );
        setState(() {
          if (response is DateTime) {
            cubit.groupExpense.dateState = response;
          }
        });
      },
      child: Text(
        cubit.dateString,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
