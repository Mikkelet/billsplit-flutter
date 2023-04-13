import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayerView extends StatelessWidget {
  final IndividualExpense individualExpense;

  const PayerView({Key? key, required this.individualExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final person = individualExpense.person;
    final isPayer = cubit.groupExpense.payerState == person;
    return GestureDetector(
      onTap: () {
        cubit.onPayerSelected(person);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(child: Image.network(person.pfpUrl)),
              isPayer
                  ? const Icon(
                      color: Colors.greenAccent,
                      Icons.attach_money_rounded,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
