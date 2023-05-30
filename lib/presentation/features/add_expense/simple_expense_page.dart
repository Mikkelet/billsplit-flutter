import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/dialogs/dialog_with_close_button.dart';
import 'package:billsplit_flutter/presentation/dialogs/participants_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/description_text_field.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_currency.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/paid_by_dropdown.dart';
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
      TextEditingController(text: expense.expenseState.fmtTextField());

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
              Row(
                children: [
                  Expanded(
                    child: RoundedListItem(
                      height: 64,
                      padding: EdgeInsets.zero,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: ExpenseTextField(
                        onChange: (value) {
                          cubit.updateSharedExpense(expense, value);
                        },
                        fontSize:
                            Theme.of(context).textTheme.titleLarge?.fontSize,
                        textAlign: TextAlign.center,
                        autoFocus: textController.text.isEmpty,
                        textEditingController: textController,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const SizedBox(
                    width: 64,
                    height: 64,
                    child: ExpenseCurrencyButton(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              DescriptionTextField(
                  initialText: cubit.groupExpense.descriptionState),
              //const LongPressTipView(),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: RoundedListItem(
                      height: 64,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                        top: Radius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfilePictureStack(
                            size: 32,
                            people: expense.participantsState,
                            limit: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getExpensePerParticipant().fmt2dec(),
                                style: Theme.of(context).textTheme.labelLarge,
                                textAlign: TextAlign.end,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                cubit.groupExpense.currencyState.symbol
                                    .toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const SizedBox(width: 8)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    height: 64,
                    width: 64,
                    child: ClickableListItem(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      onClick: () async {
                        final response = await showDialog(
                          context: context,
                          builder: (context) {
                            return DialogWithCloseButton(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: ParticipantsPickerDialog(
                                  participants: expense.participantsState,
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
                      child: const Icon(
                        Icons.group,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              PaidByDropDownView(
                  participants: getParticipatingPeople(), showExpenses: false),
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
