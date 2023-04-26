import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_state.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/add_shared_expense_view.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/description_text_field.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/shared_expense_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/reset_changes_dialog.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatelessWidget {
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
        },
        child: BaseBlocBuilder<AddExpenseBloc>(
          builder: (cubit, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      if (groupExpense.total > 0) {
                        cubit.addExpense();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const CustomDialog(
                            title: "Please enter an expense",
                            text: "Total expenses cannot be \$0",
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.check),
                  )
                ],
              ),
              body: WillPopScope(
                onWillPop: () async {
                  if (groupExpense.isChanged) {
                    return await showDialog(
                      context: context,
                      builder: (context) => ResetChangesDialog(
                        () {
                          groupExpense.resetChanges();
                        },
                      ),
                    );
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
                        child: Column(children: [
                          RoundedListItem(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30),
                              bottom: Radius.circular(10),
                            ),
                            child: Column(
                              children: [
                                ...groupExpense.sharedExpensesState.map(
                                  (e) => SharedExpenseView(sharedExpense: e),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          groupExpense.addNewSharedExpense(withParticipants: group.people);
                                          cubit.onExpensesUpdated();
                                        },
                                        icon: const Icon(Icons.bolt),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          final sharedExpense =
                                              SharedExpense.newInstance(
                                                  [...cubit.group.people]);
                                          try {
                                            final response = await showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: AddSharedExpenseView(
                                                  onConfirm: () {},
                                                  group: cubit.group,
                                                  sharedExpense: sharedExpense,
                                                ),
                                              ),
                                            );
                                            if (response != null) {
                                              sharedExpense.participantsState =
                                                  response;
                                              groupExpense.sharedExpensesState
                                                  .add(sharedExpense);
                                              cubit.onExpensesUpdated();
                                            }
                                          } catch (e) {
                                            // no op
                                          }
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
                          RoundedListItem(
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(30),
                                top: Radius.circular(10)),
                            child: Column(
                              children: [
                                ...groupExpense.individualExpenses.mapIndexed(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total"),
                                Text(
                                  "\$${groupExpense.total.fmt2dec()}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          RoundedListItem(
                              child: DescriptionTextField(
                            initialText: groupExpense.descriptionState,
                          )),
                          const SizedBox(height: 120),
                        ]),
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
