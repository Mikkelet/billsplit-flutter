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
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AdvancedExpensePage extends StatelessWidget with WidgetsBindingObserver {
  final GroupExpense groupExpense;
  final Group group;
  final PageController pageController;

  const AdvancedExpensePage({required this.groupExpense,
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
                MutableValue(
                    mutableValue: groupExpense.sharedExpensesState,
                    builder: (context, sharedExpenses) {
                      return SharedExpensesView(
                          showAll: sharedExpenses.length <= 3);
                    }),
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
                                color: Theme
                                    .of(context)
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
            MutableValue(
                mutableValue: groupExpense.descriptionState,
                builder: (context, description) {
                  return DescriptionTextField(initialText: description);
                }),
            const SizedBox(height: 8),
            DatePickerView(),
            //const LongPressTipView(),
            const SizedBox(height: 8),
            const ExpenseTotalView(),
            const SizedBox(height: 8),
            MutableValue.fromStream(
                stream: getParticipatingPeople(), builder: (context, people) {
              return PaidByDropDownView(people: people);
            }),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Stream<Iterable<Person>> getParticipatingPeople() {
    final pastMembers = groupExpense.sharedExpensesState.stateStream
        .map((event) => event.map((e) => e.participantsState.value))
        .map((event) => event.flatMap());
    return pastMembers.zipWith(group.peopleState.stateStream, (t, s) => {...t, ...s});
  }
}
