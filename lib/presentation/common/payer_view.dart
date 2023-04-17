import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayerView extends StatelessWidget {
  final Person person;
  final bool isPayer;
  final Function() onClick;

  static const double iconSize = 64;
  static const double selectedIconSize = 40;

  const PayerView(
      {Key? key,
      required this.person,
      required this.isPayer,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final isSharedExpense =
        person.uid == cubit.groupExpense.sharedExpense.person.uid;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
                iconSize: iconSize,
                onPressed: isSharedExpense ? null : onClick,
                padding: EdgeInsets.zero,
                icon: person.pfpUrl.isNotEmpty
                    ? ClipOval(
                        child: Image.network(
                          person.pfpUrl,
                          fit: BoxFit.cover,
                          height: iconSize,
                          width: iconSize,
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: iconSize,
                      )),
            isPayer
                ? const Icon(
                    color: Colors.greenAccent,
                    Icons.attach_money_rounded,
                    size: selectedIconSize,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
