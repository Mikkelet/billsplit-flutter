import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/shared_expense_description_view.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/presentation/dialogs/participants_picker_dialog.dart';
import 'package:flutter/material.dart';

class AddSharedExpenseView extends StatefulWidget {
  final SharedExpense sharedExpense;
  final Group group;
  final Function() onSubmit;

  const AddSharedExpenseView(
      {Key? key,
      required this.sharedExpense,
      required this.group,
      required this.onSubmit})
      : super(key: key);

  @override
  State<AddSharedExpenseView> createState() => _AddSharedExpenseViewState();
}

class _AddSharedExpenseViewState extends State<AddSharedExpenseView> {
  late final textController =
      TextEditingController(text: "${widget.sharedExpense.expenseState}");

  @override
  void initState() {
    textController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final group = widget.group;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _isReadyToSubmit() ? widget.onSubmit : null,
                  icon: const Icon(Icons.check),
                )
              ],
            ),
            SharedExpenseDescriptionView(
                autoFocus: true,
                sharedExpense: widget.sharedExpense,
                showIcon: true,
                alignRight: true),
            ExpenseTextField(
              textEditingController: textController,
              onChange: (value) {
                widget.sharedExpense.expenseState = value;
              },
            ),
            const SizedBox(height: 16),
            ParticipantsPickerDialog(
              participants: widget.sharedExpense.participantsState,
              showSubmit: false,
              people: group.people,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  bool _isReadyToSubmit() {
    final sharedExpense = widget.sharedExpense;
    return sharedExpense.expenseState > 0 &&
        sharedExpense.participantsState.isNotEmpty;
  }
}
