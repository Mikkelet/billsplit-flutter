import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/reset_changes_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/advanced_expense_page.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_state.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/simple_expense_page.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/delete_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/view_pager_title.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/submit_expense_button.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Page {
  simple(0),
  advanced(1);

  final int pageIndex;

  const Page(this.pageIndex);
}

class AddExpensePage extends StatefulWidget with WidgetsBindingObserver {
  final GroupExpense groupExpense;
  final Group group;
  final Page openOnPage;

  const AddExpensePage({
    required this.groupExpense,
    required this.group,
    this.openOnPage = Page.simple,
    super.key,
  });

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();

  static const String routeName = "add_expense";

  static Route getRoute(Person user, Group group, GroupExpense? expense) {
    if (expense == null) {
      return slideUpRoute(
          AddExpensePage(
            group: group,
            groupExpense: GroupExpense.newExpense(user, group),
          ),
          routeName: routeName);
    } else {
      final numOfSharedExpenses = expense.sharedExpensesState.value.length;
      final openOnPage = numOfSharedExpenses > 1 ? Page.advanced : Page.simple;
      return slideUpRoute(
          AddExpensePage(
              group: group, openOnPage: openOnPage, groupExpense: expense),
          routeName: routeName);
    }
  }
}

class _AddExpensePageState extends SafeState<AddExpensePage> {
  late final PageController pageController =
      PageController(initialPage: widget.openOnPage.pageIndex);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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
            return BaseScaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
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
                      ExpenseViewPagerTitle(pageController: pageController),
                      Expanded(
                        flex: 1,
                        child: PageView(
                          onPageChanged: (index) async {
                            if (index == Page.simple.index) {
                              onChangeToSimple(context);
                            }
                          },
                          controller: pageController,
                          children: [
                            SimpleExpensePage(
                                groupExpense: widget.groupExpense,
                                group: widget.group),
                            AdvancedExpensePage(
                                pageController: pageController,
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

  void onChangeToSimple(BuildContext context) async {
    final cubit = context.read<AddExpenseBloc>();
    if (cubit.groupExpense.sharedExpensesState.value.length > 1) {
      final response = await showDialog(
          context: context,
          builder: (context) => const CustomDialog(
                title: "You're about to switch to single-mode",
                text:
                    "You have added sub-expenses. Switching to single-mode would discard them. Are you sure?",
                primaryText: "Yes, discard",
                secondaryText: "No, stay with multiple",
              ));
      if (response is bool && response == true) {
        cubit.switchToSingle();
      } else {
        pageController.animateToPage(1,
            duration: 500.ms, curve: Curves.fastEaseInToSlowEaseOut);
      }
    }
  }
}
