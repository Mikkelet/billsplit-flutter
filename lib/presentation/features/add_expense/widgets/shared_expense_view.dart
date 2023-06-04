import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/shared_expense_description_view.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/dialogs/dialog_with_close_button.dart';
import 'package:billsplit_flutter/presentation/dialogs/participants_picker_dialog.dart';
import 'package:billsplit_flutter/utils/list_position.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SharedExpenseView extends StatefulWidget {
  final SharedExpense sharedExpense;
  final bool autoFocus;
  final ListPosition listPosition;

  const SharedExpenseView({
    super.key,
    required this.sharedExpense,
    this.autoFocus = false,
    required this.listPosition,
  });

  @override
  State<SharedExpenseView> createState() => _SharedExpenseViewState();
}

class _SharedExpenseViewState extends SafeState<SharedExpenseView> {
  late final textController = TextEditingController(
      text: widget.sharedExpense.expenseState.fmtTextField());
  final double participantsIconSize = 20;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final canSwipe = cubit.groupExpense.sharedExpensesState.length > 1;
    final showAnimation =
        canSwipe && !cubit.sharedPrefs.hasDeletedSharedExpense;

    return Column(
      children: [
        Dismissible(
          key: Key(widget.sharedExpense.hashCode.toString()),
          behavior: HitTestBehavior.translucent,
          onUpdate: (details) {
            if (details.direction == DismissDirection.endToStart) {
              cubit.sharedPrefs.hasDeletedSharedExpense = true;
            }
          },
          direction:
              canSwipe ? DismissDirection.endToStart : DismissDirection.none,
          onDismissed: (direction) {
            cubit.removeSharedExpense(widget.sharedExpense);
          },
          background: RoundedListItem(
            color: Theme.of(context).colorScheme.background,
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
              ],
            ),
          ),
          child: RoundedListItem(
            borderRadius: widget.listPosition
                .getBorderRadius(hardCorner: 10, softCorner: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 8,
                      child: SharedExpenseDescriptionView(
                        showIcon: false,
                        sharedExpense: widget.sharedExpense,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ExpenseTextField(
                        showErrorText: false,
                        fontSize:
                            Theme.of(context).textTheme.labelLarge?.fontSize,
                        prefix: cubit.groupExpense.currencyState.symbol.toUpperCase(),
                        onChange: (value) {
                          cubit.updateSharedExpense(widget.sharedExpense, value);
                        },
                        autoFocus: widget.autoFocus,
                        textEditingController: textController,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    _editParticipants(context);
                  },
                  style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.zero)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfilePictureStack(
                        people: widget.sharedExpense.participantsState,
                        size: participantsIconSize,
                        limit: 4,
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                ),
              ],
            ),
          ).animate(autoPlay: showAnimation, delay: 1000.ms, effects: [
            SlideEffect(
                begin: Offset.zero,
                end: const Offset(-0.1, 0),
                duration: 100.ms,
                curve: Curves.fastLinearToSlowEaseIn),
            SlideEffect(
                delay: 1000.ms,
                end: const Offset(0.1, 0),
                duration: 100.ms,
                curve: Curves.fastLinearToSlowEaseIn)
          ]),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  void _editParticipants(BuildContext context) async {
    final cubit = context.read<AddExpenseBloc>();
    final response = await showDialog(
      context: context,
      builder: (context) {
        return DialogWithCloseButton(
          title: "Expense Participants",
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ParticipantsPickerDialog(
              participants: [...widget.sharedExpense.participantsState],
              people: cubit.group.people,
            ),
          ),
        );
      },
    );
    if (response is List<Person>) {
      cubit.updateParticipantsForExpense(widget.sharedExpense, response);
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
