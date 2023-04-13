import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/add_service/bloc/add_service_bloc.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddServicePage extends StatelessWidget {
  final SubscriptionService service;
  late final _nameTextController = TextEditingController(text: service.name);
  late final _expenseTextController =
      TextEditingController(text: "${service.monthlyExpenseState}");

  AddServicePage({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddServiceBloc(),
      child: BlocBuilder<AddServiceBloc, UiState>(builder: (context, state) {
        return Scaffold(
          appBar: builder(() {
            if (state is Main) {
              return AppBar(leading: const BackButton(), actions: [
                IconButton(
                    onPressed: () {
                      context.read<AddServiceBloc>().submitService();
                    },
                    icon: const Icon(Icons.check))
              ]);
            }
            return null;
          }),
          body: Builder(builder: (context) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Column(
                children: [
                  TextField(controller: _nameTextController),
                  ExpenseTextField(
                      initValue: service.monthlyExpenseState,
                      textEditingController: _expenseTextController,
                      onChange: (value) {
                        service.monthlyExpenseState = value;
                        context.read<AddServiceBloc>().monthlyExpenseUpdated();
                      }),
                  Text(
                      "Participants will pay \$${_getMonthlyServicePerPerson()} every month"),
                ],
              ),
            );
          }),
        );
      }),
    );
  }

  num _getMonthlyServicePerPerson() {
    try {
      return service.monthlyExpenseState / service.participants.length;
    } catch (e) {
      return 0;
    }
  }

  static Route<AddServicePage> getRoute(
      Person user, Group group, SubscriptionService? subscriptionService) {
    if (subscriptionService == null) {
      return MaterialPageRoute(
          builder: (context) => AddServicePage(
              service:
                  SubscriptionService.newService(group: group, user: user)));
    }
    return MaterialPageRoute(
        builder: (context) => AddServicePage(service: subscriptionService));
  }
}
