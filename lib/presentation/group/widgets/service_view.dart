import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:flutter/material.dart';

class ServiceView extends StatelessWidget {
  final SubscriptionService service;

  const   ServiceView(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(service.name),
          Text(service.monthlyExpense.toString()),
        ],
      ),
    );
  }
}
