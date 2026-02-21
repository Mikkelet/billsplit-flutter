import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/add_shared_expense_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/add_surcharge.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/date_picker_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/description_text_field.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_total_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/paid_by_dropdown.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/scan_receipt_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/shared_expenses_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvancedExpensePage extends StatelessWidget with WidgetsBindingObserver {
  const AdvancedExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final group = cubit.state.group;
    final groupExpense = cubit.state.groupExpense;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Shared Expenses
            Column(
              children: [
                SharedExpensesView(
                  showAll: groupExpense.sharedExpenses.length <= 3,
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const ScanReceiptButton(),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Add as many as you need!\nSwipe to delete",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                          ),
                        ),
                      ),
                      const AddSharedExpenseButton(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DescriptionTextField(initialText: groupExpense.description),
            const SizedBox(height: 8),
            AddSurcharge(initialValue: groupExpense.surcharges.first.value),
            const SizedBox(height: 8),
            DatePickerView(),
            //const LongPressTipView(),
            const SizedBox(height: 8),
            const ExpenseTotalView(),
            const SizedBox(height: 8),
            PaidByDropDownView(people: getParticipatingPeople(groupExpense, group)),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  List<Person> getParticipatingPeople(GroupExpense groupExpense, Group group) {
    final pastMembers = groupExpense.sharedExpenses
        .map((event) => event.map((e) => e.participants))
        .flatMap();
    return [...pastMembers, ...group.people];
  }
}
