import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/advanced_expense_page.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_state.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/simple_expense_page.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/delete_button.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/dialogs/reset_changes_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/view_pager_title.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/submit_expense_button.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatefulWidget with WidgetsBindingObserver {
  final GroupExpense groupExpense;
  final Group group;

  const AddExpensePage(
      {required this.groupExpense, required this.group, super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();

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

class _AddExpensePageState extends State<AddExpensePage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => AddExpenseBloc(widget.group, widget.groupExpense),
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
                  if (widget.groupExpense.isChanged) {
                    final response = await showDialog(
                      context: context,
                      builder: (context) => ResetChangesDialog(
                        () {
                          widget.groupExpense.resetChanges();
                        },
                      ),
                    );
                    return response ?? false;
                  }
                  return true;
                },
                child: Builder(builder: (context) {
                  if (state is Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: [
                      const SizedBox(height: 16),
                      ExpenseViewPagerTitle(pageController: pageController),
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          children: [
                            SimpleExpensePage(
                                groupExpense: widget.groupExpense,
                                group: widget.group),
                            AdvancedExpensePage(
                                groupExpense: widget.groupExpense,
                                group: widget.group),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }

  Iterable<Person> getParticipatingPeople() {
    final Iterable<Person> pastMembers = [
      ...widget.groupExpense.sharedExpensesState
          .map((e) => e.participantsState)
          .toList()
    ].flatMap().toSet();
    return <Person>{...pastMembers, ...widget.group.people};
  }
}
