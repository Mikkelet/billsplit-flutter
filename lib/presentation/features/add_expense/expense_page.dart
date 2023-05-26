import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_state.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/add_shared_expense_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/delete_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_description_textfield.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_total_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/long_press_tip_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/quick_add_shared_expense_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/scan_receipt_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/shared_expense_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/reset_changes_dialog.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/submit_expense_button.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ScanReceiptButton(),
                                        SizedBox(width: 16),
                                        QuickAddSharedExpenseButton(),
                                        AddSharedExpenseButton(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const ExpenseDescriptionAndCurrencyView(),
                            const LongPressTipView(),
                            const SizedBox(height: 8),
                            // Individual expenses
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
                            const ExpenseTotalView(),
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

  static const String routeName = "add_expense";

  static Route getRoute(Person user, Group group, GroupExpense? expense) {
    if (expense == null) {
      return slideUpRoute(
          AddExpensePage(
              group: group, groupExpense: GroupExpense.newExpense(user, group)),
          routeName: routeName);
    } else {
      return slideUpRoute(AddExpensePage(group: group, groupExpense: expense),
          routeName: routeName);
    }
  }
}
