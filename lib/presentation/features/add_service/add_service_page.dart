import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_state.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_service/widgets/service_participant_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/dialog_with_close_button.dart';
import 'package:billsplit_flutter/presentation/dialogs/participants_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/reset_changes_dialog.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class AddServicePage extends StatefulWidget {
  final SubscriptionService service;
  final Group group;

  const AddServicePage({Key? key, required this.service, required this.group})
      : super(key: key);

  @override
  State<AddServicePage> createState() => _AddServicePageState();

  static Route<AddServicePage> getRoute(
      Person user, Group group, SubscriptionService? subscriptionService) {
    if (subscriptionService == null) {
      return MaterialPageRoute(
          builder: (context) => AddServicePage(
              group: group,
              service:
                  SubscriptionService.newService(group: group, user: user)));
    }
    return MaterialPageRoute(
        builder: (context) =>
            AddServicePage(group: group, service: subscriptionService));
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
  void dispose() {
    _nameTextController.dispose();
    _expenseTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;
    return BaseBlocWidget(
      listener: (context, cubit, state) {
        if (state is ServiceAdded) {
          Navigator.of(context).pop();
        } else if (state is ServiceDeleted) {
          Navigator.of(context).pop();
        }
      },
      create: (context) => AddServiceBloc(service, widget.group),
      child: BaseBlocBuilder<AddServiceBloc>(
        builder: (cubit, state) {
          return Scaffold(
            appBar: builder(() {
              return AppBar(leading: const BackButton(), actions: [
                if (service.id.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          text:
                              "Are you sure you want to delete this subscription service?",
                          primaryText: "No, keep it",
                          onPrimaryClick: () {
                            Navigator.of(context).pop();
                          },
                          secondaryText: "Yes, delete it",
                          onSecondaryClick: () {
                            Navigator.of(context).pop();
                            cubit.deleteService(service);
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                  ),
                IconButton(
                  onPressed:
                      service.isChanged && service.monthlyExpenseState > 0
                          ? () {
                              if (isValid()) {
                                cubit.submitService();
                              } else {
                                showCannotBe0ZeroError = true;
                                setState(() {});
                              }
                            }
                          : null,
                  icon: const Icon(Icons.check),
                )
              ]);
            }),
            body: WillPopScope(
              onWillPop: () async {
                if (service.isChanged) {
                  return await showDialog(
                    context: context,
                    builder: (context) => ResetChangesDialog(
                      () {
                        service.resetChanges();
                      },
                    ),
                  );
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Builder(
                  builder: (context) {
                    if (state is Loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 40),
                      child: Column(
                        children: [
                          RoundedListItem(
                            child: TextField(
                              controller: _nameTextController,
                              onChanged: (value) {
                                service.nameState = value;
                                cubit.onServiceUpdated();
                              },
                              textInputAction: TextInputAction.next,
                              maxLines: 1,
                              maxLength: 30,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              decoration: InputDecoration(
                                  errorText: nameErrorText,
                                  counterText: "",
                                  border: InputBorder.none,
                                  hintText: "Netflix, rent, etc"),
                            ),
                          ),
                          const SizedBox(height: 8),
                          RoundedListItem(
                            child: Row(
                              children: [
                                SimpleButton(
                                    onClick: () async {
                                      final response =
                                          await Navigator.of(context).push(
                                              CurrencyPickerDialog.getRoute(
                                                  convertToCurrency: cubit.group
                                                      .defaultCurrencyState));
                                      if (response is Currency) {
                                        cubit.updateCurrency(response.symbol);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(cubit.service.currencyState
                                            .toUpperCase()),
                                        const Icon(Icons.arrow_drop_down)
                                      ],
                                    )),
                                Expanded(
                                  child: ExpenseTextField(
                                      textEditingController:
                                          _expenseTextController,
                                      canBeZero: !showCannotBe0ZeroError,
                                      onChange: (value) {
                                        service.monthlyExpenseState = value;
                                        cubit.onServiceUpdated();
                                      }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          RoundedListItem(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Participants will pay ${cubit.service.currencyState.toUpperCase()} ${_getMonthlyServicePerPerson().fmt2dec()} every month"),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Builder(builder: (context) {
                            final nextMonth =
                                DateTime.now().month; // index starts at 1
                            final monthString = monthNames[
                                nextMonth]; // index starts at 0, so we get the next month by just getting the index
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Text(
                                  "Next expense will be submitted on 1st of $monthString"),
                            );
                          }),
                          const SizedBox(height: 16),
                          RoundedListItem(
                            child: Column(
                              children: [
                                ...service.participantsState.mapIndexed(
                                  (i, e) {
                                    if (i > 0) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child:
                                            ServiceParticipantView(person: e),
                                      );
                                    }
                                    return ServiceParticipantView(person: e);
                                  },
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () async {
                                      service.participantsState =
                                          await showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DialogWithCloseButton(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: ParticipantsPickerDialog(
                                              participants: [
                                                ...service.participantsState
                                              ],
                                              people: cubit.group.people,
                                            ),
                                          ),
                                        ),
                                      );
                                      if (!service.participantsState
                                          .contains(service.payerState)) {
                                        service.payerState =
                                            service.participantsState.first;
                                      }
                                      if (service.participantsState.isEmpty) {
                                        service.participantsState
                                            .add(service.payerState);
                                      }
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.group),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
                ),
              ),
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
          widget.service.participantsState.length;
    } catch (e) {
      return 0;
    }
  }
}
