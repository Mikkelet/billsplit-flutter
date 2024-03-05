import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/participant_picker/participants_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleExpenseParticipantsView extends StatelessWidget {
  final SharedExpense expense;

  const SimpleExpenseParticipantsView({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final groupExpense = cubit.groupExpense;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: RoundedListItem(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MutableValue(
                    mutableValue: expense.participantsState,
                    builder: (context, participants) {
                      return ProfilePictureStack(
                        size: 32,
                        people: participants,
                        limit: 4,
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MutableValue(
                        mutableValue: expense.expenseState,
                        builder: (context, expenseNum) {
                          return MutableValue(
                              mutableValue: expense.participantsState,
                              builder: (context, participants) {
                                final value = expenseNum / participants.length;
                                return Text(
                                  value.fmt2dec(),
                                  style: Theme.of(context).textTheme.labelLarge,
                                  textAlign: TextAlign.end,
                                );
                              });
                        }),
                    const SizedBox(width: 8),
                    MutableValue(
                        mutableValue: groupExpense.currencyState,
                        builder: (context, currency) {
                          return Text(
                            currency.symbol.toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall,
                          );
                        }),
                    const SizedBox(width: 8)
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 64,
          width: 64,
          child: ClickableListItem(
            color: Theme.of(context).colorScheme.secondaryContainer,
            onClick: () async {
              final response = await showModalBottomSheet(
                enableDrag: true,
                showDragHandle: true,
                context: context,
                builder: (context) {
                  return MutableValue(
                      mutableValue: groupExpense.sharedExpensesState,
                      builder: (context, sharedExpense) {
                        return MutableValue.fromStream(
                          stream: cubit.peopleStream,
                          builder: (context, people) {
                            return ParticipantsPickerDialog(
                              participants: expense.participantsState.value.toList(),
                              people: people,
                              onAddTempParticipant: (name) {
                                cubit.onAddTempParticipant(
                                    name, sharedExpense.first);
                              },
                            );
                          }
                        );
                      });
                },
              );
              if (response is Iterable<Person>) {
                cubit.updateParticipantsForExpense(expense, response);
              }
            },
            child: const Icon(
              Icons.group,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
