
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/dialogs/dialog_with_close_button.dart';
import 'package:billsplit_flutter/presentation/dialogs/participants_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_description_textfield.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_total_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/default_text_field.dart';

class SimpleExpensePage extends StatefulWidget with WidgetsBindingObserver {
  final GroupExpense groupExpense;
  final Group group;

  const SimpleExpensePage(
      {required this.groupExpense, required this.group, super.key});

  @override
  State<SimpleExpensePage> createState() => _SimpleExpensePageState();

  static const String routeName = "add_expense";

  static Route getRoute(Person user, Group group, GroupExpense? expense) {
    if (expense == null) {
      return slideUpRoute(
          SimpleExpensePage(
              group: group, groupExpense: GroupExpense.newExpense(user, group)),
          routeName: routeName);
    } else {
      return slideUpRoute(
          SimpleExpensePage(group: group, groupExpense: expense),
          routeName: routeName);
    }
  }
}

class _SimpleExpensePageState extends State<SimpleExpensePage> {
  late final expense = widget.groupExpense.sharedExpensesState.first;
  late final textController =
      TextEditingController(text: "${expense.expenseState}");

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Center(
          child: Column(
            children: [
              // Shared Expenses
              RoundedListItem(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                    top: Radius.circular(30),
                  ),
                  child: ExpenseTextField(
                    prefix: cubit.groupExpense.currencyState.symbol,
                    onChange: (value) {
                      expense.expenseState = value;
                      cubit.onExpensesUpdated();
                    },
                    autoFocus: textController.text.isEmpty,
                    textEditingController: textController,
                  )),
              const SizedBox(height: 4),
              const ExpenseDescriptionAndCurrencyView(),
              //const LongPressTipView(),
              const SizedBox(height: 4),
              // Individual expenses
              RoundedListItem(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                  top: Radius.circular(10),
                ),
                child: Column(
                  children: [
                    ...expense.participantsState.mapIndexed(
                      (i, e) {
                        if (i > 0) {
                          return Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: IndividualExpenseView(e));
                        }
                        return IndividualExpenseView(e);
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondaryContainer,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer)),
                        onPressed: () async {
                          final response = await showDialog(
                            context: context,
                            builder: (context) {
                              return DialogWithCloseButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: ParticipantsPickerDialog(
                                    participants: [...getParticipatingPeople()],
                                    people: cubit.group.people,
                                  ),
                                ),
                              );
                            },
                          );
                          if (response is List<Person>) {
                            cubit.updateParticipantsForExpense(
                                expense, response);
                          }
                        },
                        icon: const Icon(Icons.group),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              const ExpenseTotalView(),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Set<Person> getParticipatingPeople() {
    final Iterable<Person> pastMembers = expense.participantsState;
    return <Person>{...pastMembers, ...widget.group.people};
  }
}
