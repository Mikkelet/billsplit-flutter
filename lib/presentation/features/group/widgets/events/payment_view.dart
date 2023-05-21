import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class PaymentView extends StatelessWidget {
  final Payment payment;

  const PaymentView({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text =
        "${payment.createdBy.nameState} paid ${payment.currency.symbol.toUpperCase()} ${payment.amount.fmt2dec()} to ${payment.paidTo.nameState}";
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withAlpha(125),
              ),
        ),
      ),
    );
  }
}
