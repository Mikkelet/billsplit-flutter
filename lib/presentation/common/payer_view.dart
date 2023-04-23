import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:flutter/material.dart';

class PayerView extends StatelessWidget {
  final Person person;
  final bool isPayer;
  final bool isSharedExpense;
  final Function() onClick;

  static const double iconSize = 64;
  static const double selectedIconSize = 40;

  const PayerView(
      {Key? key,
      required this.person,
      required this.isPayer,
      required this.onClick,
      this.isSharedExpense = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            iconSize: iconSize,
            onPressed: isSharedExpense ? null : onClick,
            padding: EdgeInsets.zero,
            icon: ProfilePictureView(person: person, size: iconSize),
          ),
          if (isPayer)
            const Icon(
              color: Colors.greenAccent,
              Icons.attach_money_rounded,
              size: selectedIconSize,
            )
        ],
      ),
    );
  }
}
