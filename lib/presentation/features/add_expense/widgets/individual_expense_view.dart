import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/common/payer_view.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualExpenseView extends StatelessWidget {
  final Person person;

  const IndividualExpenseView(this.person, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PayerView(
                person: person,
                isPayer: _isPayer(person, cubit),
                size: 50,
                onClick: () {
                  cubit.onPayerSelected(person);
                },
              ),
              Builder(
                builder: (context) {
                  return Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () {
                        cubit.onPayerSelected(person);
                      },
                      onLongPress: () {
                        HapticFeedback.heavyImpact();
                        cubit.addExpenseForUser(person);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          person.nameState,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Builder(
            builder: (context) {
              if (getTotalForUser(cubit) > 0) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: SizedBox()),
                    Text(
                      getTotalForUser(cubit).fmt2dec(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      cubit.groupExpense.currencyState.symbol.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 10),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        )
      ],
    );
  }

  num getTotalForUser(AddExpenseBloc cubit) {
    return cubit.groupExpense.getSharedExpensesForPerson(person);
  }

  bool _isPayer(Person person, AddExpenseBloc cubit) {
    return cubit.groupExpense.payerState.uid == person.uid;
  }
}
