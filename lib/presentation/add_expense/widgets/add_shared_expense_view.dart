import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/shared_expense_description_view.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/presentation/dialogs/participants_picker_dialog.dart';
import 'package:flutter/material.dart';

class AddSharedExpenseView extends StatefulWidget {
  final SharedExpense sharedExpense;
  final Group group;
  final Function() onConfirm;

  const AddSharedExpenseView(
      {Key? key,
      required this.sharedExpense,
      required this.group,
      required this.onConfirm})
      : super(key: key);

  @override
  State<AddSharedExpenseView> createState() => _AddSharedExpenseViewState();
}

class _AddSharedExpenseViewState extends State<AddSharedExpenseView> {
  late final textController =
      TextEditingController(text: "${widget.sharedExpense.expenseState}");

  @override
  Widget build(BuildContext context) {
    final group = widget.group;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExpenseTextField(
              textEditingController: textController,
              onChange: (value) {
                widget.sharedExpense.expenseState = value;
              },
            ),
            SharedExpenseDescriptionView(
                sharedExpense: widget.sharedExpense,
                showIcon: true,
                alignRight: true),
            const SizedBox(
              height: 16,
            ),
            ParticipantsPickerDialog(
                participants: widget.sharedExpense.participantsState,
                people: group.people),
          ],
        ),
      ),
    );
  }
}
