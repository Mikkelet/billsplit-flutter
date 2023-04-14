import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:flutter/material.dart';

class ServiceView extends StatelessWidget {
  final SubscriptionService service;

  const ServiceView(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedListItem(
      child: Row(
        children: [
          ClipOval(
              child: Image.network(
            service.payerState.pfpUrl,
            height: 64,
            width: 64,
            fit: BoxFit.fitWidth,
          )),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(service.nameState),
              Text(
                  "\$${service.monthlyExpenseState} is paid by by ${service.payerState.nameState}"),
            ],
          ),
        ],
      ),
    );
  }
}
