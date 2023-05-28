import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/add_shared_expense_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_description_textfield.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_total_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/guide_choose_payer.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/quick_add_shared_expense_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/scan_receipt_button.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/shared_expense_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/list_position.dart';

class AdvancedExpensePage extends StatelessWidget with WidgetsBindingObserver {
  final GroupExpense groupExpense;
  final Group group;

  const AdvancedExpensePage(
      {required this.groupExpense, required this.group, super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Center(
          child: Column(
            children: [
              // Shared Expenses
              Stack(
                children: [
                  Column(
                    children: [
                      ...groupExpense.sharedExpensesState.mapIndexed((i, e) {
                        final listPos = ListPosition.calculatePosition(
                            i, groupExpense.sharedExpensesState);
                        return SharedExpenseView(
                          sharedExpense: e,
                          listPosition: listPos,
                          autoFocus: listPos == ListPosition.last,
                        );
                      }),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ScanReceiptButton(),
                            Expanded(child: SizedBox()),
                            QuickAddSharedExpenseButton(),
                            AddSharedExpenseButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: GuideView(
                      text:
                          "Here you can see sub-expenses.\n Add as many as you need!",
                      show: !cubit.sharedPrefs.hasSeenSharedExpenseGuide,
                      onClick: () {
                        cubit.sharedPrefs.hasSeenSharedExpenseGuide = true;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              const ExpenseDescriptionAndCurrencyView(),
              //const LongPressTipView(),
              const SizedBox(height: 4),
              // Individual expenses
              Stack(
                children: [
                  RoundedListItem(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                      top: Radius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ...getParticipatingPeople().mapIndexed(
                          (i, e) {
                            final isMiddleElement = i > 0;
                            if (isMiddleElement) {
                              return Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: IndividualExpenseView(e));
                            }
                            return IndividualExpenseView(e);
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: GuideView(
                      show: !cubit.sharedPrefs.hasSeenChoosePayerGuide,
                      text:
                          "Here you choose who pays and see their individual expenses!",
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(30),
                        top: Radius.circular(10),
                      ),
                      onClick: () {
                        cubit.sharedPrefs.hasSeenChoosePayerGuide = true;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              const ExpenseTotalView(),
              const SizedBox(height: 120),
            ],
          ),
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
          AdvancedExpensePage(
              group: group, groupExpense: GroupExpense.newExpense(user, group)),
          routeName: routeName);
    } else {
      return slideUpRoute(
          AdvancedExpensePage(group: group, groupExpense: expense),
          routeName: routeName);
    }
  }
}
