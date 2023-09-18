import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/common/payer_view.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualExpenseView extends StatelessWidget {
  final Person person;
  final bool showExpense;

  const IndividualExpenseView(this.person,
      {this.showExpense = true, super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final isPayer = cubit.groupExpense.payerState.uid == person.uid;
    return Container(
      decoration: isPayer
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.secondaryContainer)
          : null,
      child: Row(
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
                  isPayer: isPayer,
                  size: 48,
                  onClick: () {
                    cubit.onPayerSelected(person);
                  },
                ),
                const SizedBox(width: 8),
                Builder(
                  builder: (context) {
                    return Expanded(
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
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
                          child: Builder(builder: (context) {
                            return Text(
                              person.displayName,
                              style: Theme.of(context).textTheme.labelSmall,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            );
                          }),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          if (showExpense)
            Flexible(
              flex: 1,
              child: Builder(
                builder: (context) {
                  if (getTotalForUser(cubit) > 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${getTotalForUser(cubit).fmt2dec()} ${cubit.groupExpense.currencyState.symbol.toUpperCase()}",
                        style: Theme.of(context).textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
        ],
      ),
    );
  }

  num getTotalForUser(AddExpenseBloc cubit) {
    return cubit.groupExpense.getSharedExpensesForPerson(person);
  }
}
