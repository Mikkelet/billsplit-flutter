import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/simple/simple_expense_participants_vioew.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/simple/single_expense_field.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/date_picker_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/description_text_field.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/paid_by_dropdown.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleExpensePage extends StatefulWidget with WidgetsBindingObserver {
  final GroupExpense groupExpense;
  final Group group;

  const SimpleExpensePage({
    required this.groupExpense,
    required this.group,
    super.key,
  });

  @override
  State<SimpleExpensePage> createState() => _SimpleExpensePageState();
}

class _SimpleExpensePageState extends SafeState<SimpleExpensePage> {
  late final expense = widget.groupExpense.sharedExpensesState.first;
  static const double _dividerPadding = 8;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              // Shared Expenses
              SingleExpenseField(expense: expense),
              const SizedBox(height: _dividerPadding),
              DescriptionTextField(
                  initialText: cubit.groupExpense.descriptionState),
              //const LongPressTipView(),
              const SizedBox(height: _dividerPadding),
              DatePickerView(),
              const SizedBox(height: _dividerPadding),
              SimpleExpenseParticipantsView(expense: expense),
              const SizedBox(height: _dividerPadding),
              PaidByDropDownView(
                  people: getParticipatingPeople(), showExpenses: false),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  num getExpensePerParticipant() {
    return expense.expenseState / expense.participantsState.length;
  }

  Set<Person> getParticipatingPeople() {
    final Iterable<Person> pastMembers = expense.participantsState;
    return <Person>{
      ...pastMembers,
      ...widget.group.people,
      ...widget.groupExpense.tempParticipants
    };
  }
}
