import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatelessWidget {
  final GroupExpense expense;
  final Group group;
  final textFieldController = TextEditingController(text: "");

  AddExpensePage(
      {super.key, required GroupExpense groupExpense, required this.group})
      : expense = groupExpense;

  AddExpensePage.newExpense(this.group, {super.key})
      : expense = GroupExpense.newExpense(group.people);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => AddExpenseBloc(group.id, expense),
          child:
              BlocBuilder<AddExpenseBloc, UiState>(builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is Failure) {
              return Center(child: Text(state.error.toString()));
            }
            if (state is Main) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 80),
                child: Center(
                  child: Column(children: [
                    IndividualExpenseView(expense.sharedExpense),
                    ...expense.individualExpenses
                        .mapToImmutableList((e) => IndividualExpenseView(e)),
                    Text("TOTAL: \$${expense.getTotal()}"),
                  ]),
                ),
              );
            }
            return const Placeholder();
          }),
        ),
      ),
    );
  }

  static Route getRoute(Group group, GroupExpense? expense) {
    if (expense == null) {
      return MaterialPageRoute(
          builder: (context) => AddExpensePage.newExpense(group));
    } else {
      return MaterialPageRoute(
          builder: (context) =>
              AddExpensePage(group: group, groupExpense: expense));
    }
  }
}
