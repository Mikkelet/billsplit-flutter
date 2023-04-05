import 'package:billsplit_flutter/extentions.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/individual_expense_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_expense_event.dart';
import 'bloc/add_expense_state.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<StatefulWidget> createState() => _AddExpenseView();
}

class _AddExpenseView extends State<AddExpensePage> {
  final textFieldController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddExpenseBloc()..add(LoadExpenses()),
        child:
            BlocBuilder<AddExpenseBloc, AddExpenseState>(builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpensesLoaded) {
            return Center(
              child: Column(children: [
                ...state.individualExpenses
                    .mapToImmutableList((e) => IndividualExpenseView(e)),
                Text("TOTAL: \$${state.sumExpenses()}"),
              ]),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
