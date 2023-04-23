import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_state.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/description_text_field.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/shared_expense_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/utils/utils.dart';
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
                        cubit.addExpense();
                      },
                      icon: const Icon(Icons.check))
                ],
              ),
              body: SingleChildScrollView(
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
                          child: Column(
                            children: [
                              ...groupExpense.sharedExpenses.map(
                                  (e) => SharedExpenseView(sharedExpense: e)),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        cubit.groupExpense.addNewSharedExpense();
                                        cubit.onExpensesUpdated();
                                      },
                                      icon: const Icon(Icons.add))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RoundedListItem(
                          child: Column(
                            children: [
                              ...groupExpense.individualExpenses.map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IndividualExpenseView(e),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RoundedListItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("TOTAL"),
                              Text("\$${groupExpense.total.fmt2dec()}"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const RoundedListItem(child: DescriptionTextField())
                      ]),
                    ),
                  );
                }),
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
