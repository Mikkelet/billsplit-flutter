import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_state.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatelessWidget {
  final GroupExpense expense;
  final Group group;
  final textFieldController = TextEditingController(text: "");

  AddExpensePage({required this.expense, required this.group, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddExpenseBloc(group.id, expense),
      child: BlocListener<AddExpenseBloc, UiState>(
        listener: (context, state) {
          if (state is AddExpenseSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<AddExpenseBloc, UiState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        final cubit = context.read<AddExpenseBloc>();
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
                  if (state is Failure) {
                    return Center(child: Text(state.error.toString()));
                  }
                  if (state is Main) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 80),
                      child: Center(
                        child: Column(children: [
                          IndividualExpenseView(expense.sharedExpense),
                          ...expense.individualExpenses.mapToImmutableList(
                              (e) => IndividualExpenseView(e)),
                          Text("TOTAL: \$${expense.getTotal()}"),
                        ]),
                      ),
                    );
                  }
                  return const Placeholder();
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
              group: group, expense: GroupExpense.newExpense(user, group)));
    } else {
      return MaterialPageRoute(
          builder: (context) => AddExpensePage(group: group, expense: expense));
    }
  }
}
