import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/simple/simple_expense_participants_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/simple/single_expense_field.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/date_picker_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/description_text_field.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/paid_by_dropdown.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

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
  late final expense = widget.groupExpense.sharedExpensesState.value.first;
  static const double _dividerPadding = 8;

  Stream<Set<Person>> getParticipatingPeople(SharedExpense expense) {
    final pastMembers = expense.participantsState.stateStream;
    final people = widget.group.peopleState.stateStream;
    final temps = widget.groupExpense.tempParticipantsState.stateStream;
    return CombineLatestStream([
      pastMembers,
      people,
      temps
    ], (values) => values.flatMap().toSet());
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: MutableValue(
              mutableValue: cubit.groupExpense.sharedExpensesState,
              builder: (context, sharedExpenses) {
                final firstExpense = sharedExpenses.first;
                return Column(
                  children: [
                    // Shared Expenses
                    SingleExpenseField(expense: firstExpense),
                    const SizedBox(height: _dividerPadding),
                    MutableValue(
                        mutableValue: cubit.groupExpense.descriptionState,
                        builder: (context, description) {
                          return DescriptionTextField(
                            initialText: description,
                          );
                        }),
                    //const LongPressTipView(),
                    const SizedBox(height: _dividerPadding),
                    DatePickerView(),
                    const SizedBox(height: _dividerPadding),
                    SimpleExpenseParticipantsView(expense: expense),
                    const SizedBox(height: _dividerPadding),
                    StreamBuilder(
                      stream: getParticipatingPeople(firstExpense),
                      initialData: const <Person>{},
                      builder: (context, snapshot) {
                        final people = snapshot.requireData;
                        return PaidByDropDownView(
                          people: people,
                          showExpenses: false,
                        );
                      }
                    ),
                    const SizedBox(height: 120),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
