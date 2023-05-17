import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/shared_expense_description_view.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/dialogs/dialog_with_close_button.dart';
import 'package:billsplit_flutter/presentation/dialogs/participants_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SharedExpenseView extends StatefulWidget {
  final SharedExpense sharedExpense;
  final bool autoFocus;

  const SharedExpenseView(
      {super.key, required this.sharedExpense, this.autoFocus = false});

  @override
  State<SharedExpenseView> createState() => _SharedExpenseViewState();
}

class _SharedExpenseViewState extends State<SharedExpenseView> {
  late final textController =
      TextEditingController(text: "${widget.sharedExpense.expenseState}");

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: SharedExpenseDescriptionView(
                autoFocus: widget.autoFocus,
                showIcon: false,
                sharedExpense: widget.sharedExpense,
              ),
            ),
            Expanded(
              flex: 5,
              child: ExpenseTextField(
                prefix: cubit.groupExpense.currencyState.symbol,
                onChange: (value) {
                  widget.sharedExpense.expenseState = value;
                  cubit.onExpensesUpdated();
                },
                textEditingController: textController,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              final response = await showDialog(
                context: context,
                builder: (context) {
                  return DialogWithCloseButton(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ParticipantsPickerDialog(
                        participants: [
                          ...widget.sharedExpense.participantsState
                        ],
                        people: cubit.group.people,
                        extraAction: IconButton(
                          onPressed: () {
                            cubit.groupExpense
                                .removeSharedExpense(widget.sharedExpense);
                            Navigator.of(context).pop();
                            cubit.onExpensesUpdated();
                          },
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                    ),
                  );
                },
              );
              if (response != null) {
                widget.sharedExpense.participantsState = response;
              }
              cubit.onExpensesUpdated();
            },
            visualDensity: VisualDensity.compact,
            child: Align(
              alignment: Alignment.centerLeft,
              child: ProfilePictureStack(
                people: widget.sharedExpense.participantsState,
                size: 30,
                limit: 4,
              ),
            ),
          ),
        ),
        const Divider()
      ],
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
