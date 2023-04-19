import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:flutter/material.dart';

class PaymentView extends StatelessWidget {
  final Payment payment;
  const PaymentView({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
          "Payment by ${payment.createdBy.nameState}: \$${payment.amount}"),
    );
  }
}
