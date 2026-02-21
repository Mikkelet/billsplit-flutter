import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/simple/simple_expense_participants_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/simple/single_expense_field.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/date_picker_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/description_text_field.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/paid_by_dropdown.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleExpensePage extends StatelessWidget with WidgetsBindingObserver {
  const SimpleExpensePage({super.key});

  Set<Person> getParticipatingPeople(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final state = cubit.state;
    final pastMembers = state.group.pastMembers;
    final people = state.group.people;
    final temps = state.groupExpense.tempParticipants;
    return {...pastMembers, ...people, ...temps};
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final state = cubit.state;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Builder(
            builder: (context) {
              final firstExpense = state.groupExpense.sharedExpenses.first;
              return Column(
                children: [
                  // Shared Expenses
                  SingleExpenseField(expense: firstExpense),
                  const SizedBox(height: 12),
                  DescriptionTextField(
                    initialText: state.groupExpense.description,
                  ),
                  //const LongPressTipView(),
                  const SizedBox(height: 12),
                  DatePickerView(),
                  const SizedBox(height: 12),
                  SimpleExpenseParticipantsView(expense: firstExpense),
                  const SizedBox(height: 12),
                  PaidByDropDownView(
                    people: getParticipatingPeople(context),
                    showExpenses: false,
                  ),
                  const SizedBox(height: 120),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
