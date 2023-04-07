import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatelessWidget {
  final GroupExpense expense;
  final textFieldController = TextEditingController(text: "");

  AddExpensePage({super.key, required GroupExpense groupExpense})
      : expense = groupExpense;

  AddExpensePage.newExpense({super.key}) : expense = GroupExpense.newExpense();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddExpenseBloc(expense),
        child:
            BlocBuilder<AddExpenseBloc, BaseState>(builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is Failure) {
            return Center(child: Text(state.error.toString()));
          }
          if (state is Main) {
            return Center(
              child: Column(children: [
                IndividualExpenseView(expense.sharedExpense),
                ...expense.individualExpenses
                    .mapToImmutableList((e) => IndividualExpenseView(e)),
                Text("TOTAL: \$${expense.getTotal()}"),
              ]),
            );
          }
          return const Placeholder();
        }),
      ),
    );
  }

  static Route getRoute(GroupExpense? expense) {
    if (expense == null) {
      return MaterialPageRoute(
          builder: (context) => AddExpensePage.newExpense());
    } else {
      return MaterialPageRoute(
          builder: (context) => AddExpensePage(groupExpense: expense));
    }
  }
}
