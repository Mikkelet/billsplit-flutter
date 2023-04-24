import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/add_service/bloc/add_service_state.dart';
import 'package:billsplit_flutter/presentation/add_service/bloc/add_service_bloc.dart';
import 'package:billsplit_flutter/presentation/add_service/widgets/service_participant_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class AddServicePage extends StatefulWidget {
  final SubscriptionService service;
  final String groupId;

  const AddServicePage({Key? key, required this.service, required this.groupId})
      : super(key: key);

  @override
  State<AddServicePage> createState() => _AddServicePageState();

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

class _AddServicePageState extends State<AddServicePage> {
  late final _nameTextController =
      TextEditingController(text: widget.service.nameState);

  late final _expenseTextController =
      TextEditingController(text: "${widget.service.monthlyExpenseState}");

  bool showCannotBe0ZeroError = false;
  String? nameErrorText;

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      listener: (state) {
        if (state is ServiceAdded) {
          Navigator.of(context).pop();
        }
      },
      create: (context) => AddServiceBloc(widget.service, widget.groupId),
      child: BaseBlocBuilder<AddServiceBloc>(
        builder: (cubit, state) {
          return Scaffold(
            appBar: builder(() {
              return AppBar(leading: const BackButton(), actions: [
                IconButton(
                    onPressed: () {
                      if (isValid()) {
                        cubit.submitService();
                      } else {
                        showCannotBe0ZeroError = true;
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.check))
              ]);
            }),
            body: SingleChildScrollView(
              child: Builder(builder: (context) {
                if (state is Loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                  child: Column(
                    children: [
                      RoundedListItem(
                        child: TextField(
                          controller: _nameTextController,
                          onChanged: (value) {
                            widget.service.nameState = value;
                          },
                          decoration: InputDecoration(
                              errorText: nameErrorText,
                              border: InputBorder.none,
                              hintText: "Netflix, rent, etc"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      RoundedListItem(
                        child: ExpenseTextField(
                            textEditingController: _expenseTextController,
                            canBeZero: !showCannotBe0ZeroError,
                            onChange: (value) {
                              widget.service.monthlyExpenseState = value;
                              cubit.monthlyExpenseUpdated();
                            }),
                      ),
                      const SizedBox(height: 8),
                      RoundedListItem(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Participants will pay \$${_getMonthlyServicePerPerson().fmt2dec()} every month"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      RoundedListItem(
                        child: Column(
                          children: [
                            ...widget.service.participants.mapIndexed((i, e) {
                              if (i > 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: ServiceParticipantView(person: e),
                                );
                              }
                              return ServiceParticipantView(person: e);
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  bool isValid() {
    if (_nameTextController.text.isEmpty) {
      nameErrorText = "Enter a name";
    } else {
      nameErrorText = null;
    }

    try {
      return _nameTextController.text.isNotEmpty &&
          _expenseTextController.text.isNotEmpty &&
          num.parse(_expenseTextController.text) > 0;
    } catch (e) {
      return false;
    }
  }

  num _getMonthlyServicePerPerson() {
    try {
      return widget.service.monthlyExpenseState /
          widget.service.participants.length;
    } catch (e) {
      return 0;
    }
  }
}
