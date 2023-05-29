import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/dialogs/dialog_with_close_button.dart';
import 'package:billsplit_flutter/presentation/dialogs/participants_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_description_textfield.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_total_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:billsplit_flutter/utils/utils.dart';
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
}

class _SimpleExpensePageState extends SafeState<SimpleExpensePage> {
  late final expense = widget.groupExpense.sharedExpensesState.first;
  late final textController =
      TextEditingController(text: "${expense.expenseState}");

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
              RoundedListItem(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                    top: Radius.circular(30),
                  ),
                  child: SizedBox(
                    height: 64,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ExpenseTextField(
                            onChange: (value) {
                              expense.expenseState = value;
                              cubit.onExpensesUpdated();
                            },
                            textAlign: TextAlign.center,
                            autoFocus: textController.text.isEmpty,
                            textEditingController: textController,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 4),
              const ExpenseDescriptionAndCurrencyView(),
              //const LongPressTipView(),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: RoundedListItem(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                        top: Radius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfilePictureStack(
                            people: expense.participantsState,
                            limit: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getExpensePerParticipant().fmt2dec(),
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.end,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                cubit.groupExpense.currencyState.symbol
                                    .toUpperCase(),
                                style: const TextStyle(fontSize: 10),
                              ),
                              const SizedBox(width: 8)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
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
                        cubit.updateParticipantsForExpense(expense, response);
                      }
                    },
                    icon: const Icon(Icons.group),
                  ),
                  const SizedBox(width: 8)
                ],
              ),
              const SizedBox(height: 4),
              ClickableListItem(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                  top: Radius.circular(10),
                ),
                onClick: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Paid by"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ProfilePictureView(
                          person: cubit.groupExpense.payerState),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const ExpenseTotalView(),
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
    return <Person>{...pastMembers, ...widget.group.people};
  }
}
