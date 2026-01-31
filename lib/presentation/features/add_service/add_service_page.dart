import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/expense_textfield_controller.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/participant_picker/participants_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/reset_changes_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_state.dart';
import 'package:billsplit_flutter/presentation/features/add_service/widgets/service_participant_view.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class AddServicePage extends StatefulWidget {
  final SubscriptionService service;
  final Group group;

  const AddServicePage({
    super.key,
    required this.service,
    required this.group,
  });

  @override
  State<AddServicePage> createState() => _AddServicePageState();

  static Route getRoute(
      Person user, Group group, SubscriptionService? subscriptionService) {
    if (subscriptionService == null) {
      return slideUpRoute(AddServicePage(
          group: group,
          service: SubscriptionService.newService(group: group, user: user)));
    }
    return slideUpRoute(
        AddServicePage(group: group, service: subscriptionService));
  }
}

class _AddServicePageState extends SafeState<AddServicePage> {
  late final _nameTextController =
      TextEditingController(text: widget.service.nameState.value);

  late final _expenseTextController = ExpenseTextFieldController(
      text: widget.service.monthlyExpenseState.value.fmt2dec(readOnly: false));

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
          return BaseScaffold(
            appBar: builder(() {
              if (state is Loading) {
                return null;
              }
              return AppBar(
                  forceMaterialTransparency: true,
                  title: Builder(builder: (context) {
                    if (service.id.isEmpty) {
                      return const Text("New Subscription");
                    }
                    return const Text("Edit Subscription");
                  }),
                  leading: const BackButton(),
                  surfaceTintColor: Theme.of(context).colorScheme.surface,
                  actions: [
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
                                cubit.deleteService(service);
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                      ),
                    StreamBuilder(
                        stream: service.isChangedStream,
                        initialData: service.isChanged,
                        builder: (context, snapshot) {
                          final isChanged = snapshot.requireData;
                          return MutableValue(
                              mutableValue: service.monthlyExpenseState,
                              builder: (context, monthlyExpense) {
                                Function()? callback;
                                final enableButton =
                                    isChanged && monthlyExpense > 0;
                                if (enableButton) {
                                  callback = () {
                                    if (isValid()) {
                                      cubit.submitService();
                                    } else {
                                      showCannotBe0ZeroError = true;
                                    }
                                  };
                                }
                                return IconButton(
                                  onPressed: callback,
                                  icon: const Icon(Icons.check),
                                );
                              });
                        })
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
              child: Builder(builder: (context) {
                if (state is Loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 40),
                    child: Column(
                      children: [
                        RoundedListItem(
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            controller: _nameTextController,
                            onChanged: (value) {
                              service.nameState.value = value;
                            },
                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            maxLength: 30,
                            style: SplitsbyTextTheme.textFieldStyle(context),
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            decoration: InputDecoration(
                                hintStyle: SplitsbyTextTheme.textFieldHintStyle(
                                    context),
                                errorText: nameErrorText,
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "Enter a name. Netflix, rent, etc"),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: RoundedListItem(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: 64,
                                borderRadius: BorderRadius.circular(10),
                                child: ExpenseTextField(
                                    textEditingController:
                                        _expenseTextController,
                                    canBeZero: !showCannotBe0ZeroError,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.fontSize,
                                    onChange: (value) {
                                      service.monthlyExpenseState.value = value;
                                    }),
                              ),
                            ),
                            const SizedBox(width: 4),
                            SizedBox(
                              height: 64,
                              width: 64,
                              child: ClickableListItem(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                onClick: () async {
                                  final response = await Navigator.of(context)
                                      .push(CurrencyPickerDialog.getRoute(
                                          convertToCurrency: cubit.group
                                              .defaultCurrencyState.value));
                                  if (response is Currency) {
                                    cubit.updateCurrency(response.symbol);
                                  }
                                },
                                child: MutableText(
                                  mutString: cubit.service.currencyState,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        RoundedListItem(
                          borderRadius: BorderRadius.circular(10),
                          height: 64,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: MutableValue(
                                mutableValue: cubit.service.currencyState,
                                builder: (context, currency) {
                                  return MutableValue(
                                      mutableValue:
                                          cubit.service.monthlyExpenseState,
                                      builder: (context, monthlyService) {
                                        return MutableValue(
                                            mutableValue:
                                                cubit.service.participantsState,
                                            builder: (context, participants) {
                                              final monthlyServicePerPerson =
                                                  monthlyService /
                                                      participants.length;
                                              return Text(
                                                  "Participants will pay ${currency.toUpperCase()} ${monthlyServicePerPerson.fmt2dec()} every month",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall);
                                            });
                                      });
                                }),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Builder(
                          builder: (context) {
                            // index starts at 1
                            final nextMonth = DateTime.now().month;
                            // index starts at 0, so we get the next month by just getting the index
                            final monthString = monthNames[nextMonth];
                            return Text(
                              "Next expense will be submitted on 1st of $monthString",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        RoundedListItem(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(30),
                              top: Radius.circular(10)),
                          child: Column(
                            children: [
                              MutableValue(
                                  mutableValue: service.participantsState,
                                  builder: (context, participants) {
                                    return Column(
                                      children: [
                                        ...participants.mapIndexed(
                                          (i, e) {
                                            if (i > 0) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: ServiceParticipantView(
                                                    person: e),
                                              );
                                            }
                                            return ServiceParticipantView(
                                                person: e);
                                          },
                                        )
                                      ],
                                    );
                                  }),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                      context: context,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      builder: (context) => Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ParticipantsPickerDialog(
                                          participantsState: service.participantsState,
                                          peopleState: cubit.group.peopleState,
                                          currencySymbol: service.currencyState.value,
                                          description: service.nameState.value,
                                          totalExpense: cubit.service.monthlyExpenseState.value,
                                        ),
                                      ),
                                    );
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
}
