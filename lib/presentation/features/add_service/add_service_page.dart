import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/participant_picker/participants_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/reset_changes_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_state.dart';
import 'package:billsplit_flutter/presentation/features/add_service/widgets/service_participant_view.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_route.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddServicePage extends StatelessWidget {
  const AddServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddServiceBloc>();
    return BlocBuilder<AddServiceBloc, AddServiceState>(
      builder: (context, state) {
        return BaseScaffold(
          appBar: builder(() {
            if (state is Loading) {
              return null;
            }
            return AppBar(
              forceMaterialTransparency: true,
              title: Builder(
                builder: (context) {
                  if (state.requireService.id.isEmpty) {
                    return const Text("New Subscription");
                  }
                  return const Text("Edit Subscription");
                },
              ),
              leading: const BackButton(),
              surfaceTintColor: Theme.of(context).colorScheme.surface,
              actions: [
                if (state.requireService.id.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          text: "Are you sure you want to delete this subscription service?",
                          primaryText: "No, keep it",
                          onPrimaryClick: () {
                            Navigator.of(context).pop();
                          },
                          secondaryText: "Yes, delete it",
                          onSecondaryClick: () {
                            cubit.deleteService(state.requireService);
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                  ),
                Builder(
                  builder: (context) {
                    VoidCallback? callback;
                    final enableButton = cubit.isChanged && state.requireService.monthlyExpense > 0;
                    if (enableButton) {
                      callback = () {
                        cubit.submitService();
                      };
                    }
                    return IconButton(
                      onPressed: callback,
                      icon: const Icon(Icons.check),
                    );
                  },
                ),
              ],
            );
          }),
          body: PopScope(
            canPop: !cubit.isChanged,
            onPopInvokedWithResult: (didPop, result) async {
              await showDialog(
                context: context,
                builder: (context) => ResetChangesDialog(
                  () {
                    context.pop();
                  },
                ),
              );
            },
            child: Builder(
              builder: (context) {
                if (state is Loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                    child: Column(
                      children: [
                        RoundedListItem(
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            controller: cubit.nameTextController,
                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            maxLength: 30,
                            style: SplitsbyTextTheme.textFieldStyle(context),
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            decoration: InputDecoration(
                              hintStyle: SplitsbyTextTheme.textFieldHintStyle(context),
                              errorText: cubit.state.nameErrorText,
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "Enter a name. Netflix, rent, etc",
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: RoundedListItem(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                height: 64,
                                borderRadius: BorderRadius.circular(10),
                                child: ExpenseTextField(
                                  textEditingController: cubit.expenseTextController,
                                  canBeZero: !state.showCannotBe0ZeroError,
                                  fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
                                  onChange: (value) {},
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            SizedBox(
                              height: 64,
                              width: 64,
                              child: ClickableListItem(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.secondaryContainer,
                                onClick: () async {
                                  final response = await CurrencyPickerRoute(
                                    convertToCurrency: state.requireGroup.defaultCurrency,
                                  ).push(context);
                                  if (response is Currency) {
                                    cubit.updateCurrency(response.symbol);
                                  }
                                },
                                child: Text(state.requireService.currency),
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
                            child: Text(
                              "Participants will pay ${state.requireService.currency.toUpperCase()} ${cubit.monthlyServicePerPerson.fmt2dec()} every month",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
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
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        RoundedListItem(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(30),
                            top: Radius.circular(10),
                          ),
                          child: Column(
                            children: [
                              ...state.participants.mapIndexed(
                                (i, e) {
                                  if (i > 0) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: ServiceParticipantView(person: e),
                                    );
                                  }
                                  return ServiceParticipantView(person: e);
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Theme.of(context).colorScheme.surface,
                                      builder: (context) => Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ParticipantsPickerDialog(
                                          participants: state.participants,
                                          people: state.requireGroup.people,
                                          currencySymbol: state.currency,
                                          description: cubit.name,
                                          totalExpense: cubit.monthlyExpense,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.group),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
