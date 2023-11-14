import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/add_shared_expense_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/date_picker_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/description_text_field.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_total_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/paid_by_dropdown.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/scan_receipt_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/shared_expenses_view.dart';
import 'package:flutter/material.dart';


class AdvancedExpensePage extends StatelessWidget with WidgetsBindingObserver {
  final GroupExpense groupExpense;
  final Group group;
  final PageController pageController;

  const AdvancedExpensePage(
      {required this.groupExpense,
      required this.group,
      super.key,
      required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Shared Expenses
            Column(
              children: [
                SharedExpensesView(
                    showAll: groupExpense.sharedExpensesState.length <= 3),
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
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
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
            DescriptionTextField(initialText: groupExpense.descriptionState),
            const SizedBox(height: 8),
            const DatePickerView(),
            //const LongPressTipView(),
            const SizedBox(height: 8),
            const ExpenseTotalView(),
            const SizedBox(height: 8),
            PaidByDropDownView(people: getParticipatingPeople()),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Iterable<Person> getParticipatingPeople() {
    final Iterable<Person> pastMembers = [
      ...groupExpense.sharedExpensesState
          .map((e) => e.participantsState),
    ].flatMap().toSet();
    return <Person>{...pastMembers, ...group.people};
  }
}
