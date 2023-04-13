import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/add_service/bloc/add_service_state.dart';
import 'package:billsplit_flutter/presentation/add_service/bloc/add_service_bloc.dart';
import 'package:billsplit_flutter/presentation/add_service/widgets/service_participant_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddServicePage extends StatelessWidget {
  final SubscriptionService service;
  final String groupId;
  late final _nameTextController = TextEditingController(text: service.nameState);
  late final _expenseTextController =
      TextEditingController(text: "${service.monthlyExpenseState}");

  AddServicePage({Key? key, required this.service, required this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddServiceBloc(service, groupId),
      child: BlocBuilder<AddServiceBloc, UiState>(builder: (context, state) {
        return BlocListener<AddServiceBloc, UiState>(
          listener: (context, state) {
            if (state is ServiceAdded) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            appBar: builder(() {
              return AppBar(leading: const BackButton(), actions: [
                IconButton(
                    onPressed: () {
                      context.read<AddServiceBloc>().submitService();
                    },
                    icon: const Icon(Icons.check))
              ]);
            }),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Builder(builder: (context) {
                  if (state is Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 40),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16),
                              child: TextField(
                                controller: _nameTextController,
                                onChanged: (value){
                                  service.nameState = value;
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Netflix, rent, etc"),
                              ),
                            )),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpenseTextField(
                                initValue: service.monthlyExpenseState,
                                textEditingController: _expenseTextController,
                                onChange: (value) {
                                  service.monthlyExpenseState = value;
                                  context
                                      .read<AddServiceBloc>()
                                      .monthlyExpenseUpdated();
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                "Participants will pay \$${_getMonthlyServicePerPerson().fmt2dec()} every month"),
                          ),
                        ),
                        ...service.participants
                            .map((e) => ServiceParticipantView(person: e))
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
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
              groupId: group.id,
              service:
                  SubscriptionService.newService(group: group, user: user)));
    }
    return MaterialPageRoute(
        builder: (context) =>
            AddServicePage(groupId: group.id, service: subscriptionService));
  }
}
