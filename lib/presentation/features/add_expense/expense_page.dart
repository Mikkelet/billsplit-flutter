import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/common/splitsby_camera.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_state.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/add_shared_expense_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/delete_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/description_text_field.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/shared_expense_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/closable_tips_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/reset_changes_dialog.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/submit_expense_button.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/expense_currency.dart';

class AddExpensePage extends StatelessWidget with WidgetsBindingObserver {
  final GroupExpense groupExpense;
  final Group group;

  const AddExpensePage(
      {required this.groupExpense, required this.group, super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => AddExpenseBloc(group, groupExpense),
      child: BlocListener<AddExpenseBloc, UiState>(
        listener: (context, state) {
          if (state is AddExpenseSuccess) {
            Navigator.of(context).pop();
          }
          if (state is ExpenseDeleted) {
            Navigator.of(context).pop();
          }
        },
        child: BaseBlocBuilder<AddExpenseBloc>(
          builder: (cubit, state) {
            return Scaffold(
              appBar: AppBar(
                surfaceTintColor: Theme.of(context).colorScheme.surface,
                title: Builder(builder: (context) {
                  if (cubit.groupExpense.id.isEmpty) {
                    return const Text("New Expense");
                  }
                  return const Text("Edit expense");
                }),
                actions: [
                  IconButton(
                      onPressed: () async {
                        Navigator.of(context).push(SplitsbyCamera.getRoute());
                      },
                      icon: const Icon(Icons.document_scanner_outlined)),
                  if (cubit.groupExpense.id.isNotEmpty)
                    const DeleteExpenseButton(),
                  const SubmitExpenseButton()
                ],
              ),
              body: WillPopScope(
                onWillPop: () async {
                  if (groupExpense.isChanged) {
                    final response = await showDialog(
                      context: context,
                      builder: (context) => ResetChangesDialog(
                        () {
                          groupExpense.resetChanges();
                        },
                      ),
                    );
                    return response ?? false;
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  child: Builder(builder: (context) {
                    if (state is Loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24),
                      child: Center(
                        child: Column(
                          children: [
                            // Shared Expenses
                            RoundedListItem(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(30),
                                bottom: Radius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  ...groupExpense.sharedExpensesState.map(
                                    (e) => SharedExpenseView(
                                        key: Key("${e.hashCode}"),
                                        sharedExpense: e,
                                        autoFocus: builder(() {
                                          if (state is QuickAddSharedExpense) {
                                            return state.sharedExpense == e;
                                          }
                                          return false;
                                        })),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Quick add expense
                                        IconButton(
                                          onPressed: () {
                                            cubit.onQuickAddSharedExpense();
                                          },
                                          icon: const Icon(Icons.bolt),
                                        ),

                                        // Add expense
                                        IconButton(
                                          onPressed: () async {
                                            final sharedExpense =
                                                SharedExpense.newInstance(
                                                    [...cubit.group.people]);
                                            showModalBottomSheet(
                                              enableDrag: true,
                                              isScrollControlled: true,
                                              useSafeArea: true,
                                              context: context,
                                              builder: (context) =>
                                                  AddSharedExpenseView(
                                                onSubmit: () {
                                                  cubit.groupExpense
                                                      .sharedExpensesState
                                                      .add(sharedExpense);
                                                  Navigator.of(context).pop();
                                                  cubit.onExpensesUpdated();
                                                },
                                                group: cubit.group,
                                                sharedExpense: sharedExpense,
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: DescriptionTextField(
                                      initialText:
                                          groupExpense.descriptionState),
                                ),
                                const SizedBox(width: 8),
                                const Flexible(
                                  flex: 1,
                                  child: ExpenseCurrencyButton(),
                                )
                              ],
                            ),
                            // Tips and tricks
                            ClosableTipView(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 8),
                              tip:
                                  "Tip: long press a user to quick-add an expense for them",
                              hasSeen: cubit.sharedPrefs
                                  .hasSeenHoldToAddIndividualExpenseTip,
                              onClose: () {
                                cubit.sharedPrefs
                                        .hasSeenHoldToAddIndividualExpenseTip =
                                    true;
                              },
                            ),

                            // Individual expenses
                            const SizedBox(height: 8),
                            RoundedListItem(
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(30),
                                  top: Radius.circular(10)),
                              child: Column(
                                children: [
                                  ...getParticipatingPeople().mapIndexed(
                                    (i, e) {
                                      final isMiddleElement = i > 0;
                                      if (isMiddleElement) {
                                        return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: IndividualExpenseView(e));
                                      }
                                      return IndividualExpenseView(e);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            RoundedListItem(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Total"),
                                  Row(
                                    children: [
                                      Text(
                                        groupExpense.total.fmt2dec(),
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        cubit.groupExpense.currencyState.symbol
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 10),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Iterable<Person> getParticipatingPeople() {
    final Iterable<Person> pastMembers = [
      ...groupExpense.sharedExpensesState
          .map((e) => e.participantsState)
          .toList()
    ].flatMap().toSet();
    return <Person>{...pastMembers, ...group.people};
  }

  static Route getRoute(Person user, Group group, GroupExpense? expense) {
    if (expense == null) {
      return MaterialPageRoute(
          builder: (context) => AddExpensePage(
              group: group,
              groupExpense: GroupExpense.newExpense(user, group)));
    } else {
      return MaterialPageRoute(
          builder: (context) =>
              AddExpensePage(group: group, groupExpense: expense));
    }
  }
}
