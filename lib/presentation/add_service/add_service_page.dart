import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:flutter/material.dart';

class AddServicePage extends StatelessWidget {
  final SubscriptionService service;
  late final _nameTextController = TextEditingController(text: service.name);
  late final _expenseTextController =
      TextEditingController(text: "${service.monthlyExpense}");

  AddServicePage({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: _nameTextController),
          TextField(
            controller: _expenseTextController,
          ),
          Text("Participants will pay \$${_getMonthlyServicePerPerson()} every month"),
          Container()
        ],
      ),
    );
  }

  num _getMonthlyServicePerPerson() {
    try {
      return service.monthlyExpense / service.participants.length;
    } catch (e) {
      return 0;
    }
  }

  Route<AddServicePage> getRoute(
      Person user, Group group, SubscriptionService? subscriptionService) {
    if (subscriptionService == null) {
      return MaterialPageRoute(
          builder: (context) => AddServicePage(
              service:
                  SubscriptionService.newService(group: group, user: user)));
    }
    return MaterialPageRoute(
        builder: (context) => AddServicePage(service: service));
  }
}
