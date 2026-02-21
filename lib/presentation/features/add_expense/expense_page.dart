import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final state = cubit.state;
    final groupExpense = state.groupExpense;
    return BaseScaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: Builder(
          builder: (context) {
            if (groupExpense.id.isEmpty) {
              return const Text("New Expense");
            }
            return const Text("Edit expense");
          },
        ),
        actions: [
          if (groupExpense.id.isNotEmpty) const DeleteExpenseButton(),
          const SubmitExpenseButton(),
        ],
      ),
      body: PopScope(
        canPop: cubit.isChanged,
        onPopInvokedWithResult: (didPop, result) async {
          final response = await showDialog(
            context: context,
            builder: (context) => ResetChangesDialog(
              () {
                cubit.resetChanges();
              },
            ),
          );
        },
        child: Builder(
          builder: (context) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                ExpenseViewPagerTitle(pageController: cubit.pageController),
                Expanded(
                  flex: 1,
                  child: PageView(
                    onPageChanged: (index) async {
                      if (index == ExpenseView.simple.index) {
                        onChangeToSimple(context);
                      }
                    },
                    controller: cubit.pageController,
                    children: [
                      SimpleExpensePage(),
                      AdvancedExpensePage(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void onChangeToSimple(BuildContext context) async {
    final cubit = context.read<AddExpenseBloc>();
    if (cubit.state.groupExpense.sharedExpenses.length > 1) {
      final response = await showDialog(
        context: context,
        builder: (context) => const CustomDialog(
          title: "You're about to switch to single-mode",
          text:
              "You have added sub-expenses. Switching to single-mode would discard them. Are you sure?",
          primaryText: "Yes, discard",
          secondaryText: "No, stay with multiple",
        ),
      );
      if (response is bool && response == true) {
        cubit.switchToSingle();
      } else {
        cubit.pageController.animateToPage(
          1,
          duration: 500.ms,
          curve: Curves.fastEaseInToSlowEaseOut,
        );
      }
    }
  }
}
