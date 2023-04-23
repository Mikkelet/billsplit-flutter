import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/shared_expense_people_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SharedExpenseView extends StatefulWidget {
  final SharedExpense sharedExpense;

  const SharedExpenseView({super.key, required this.sharedExpense});

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
        ExpenseTextField(
          onChange: (value) {
            widget.sharedExpense.expenseState = value;
            cubit.onExpensesUpdated();
          },
          textEditingController: textController,
        ),
        Row(
          children: [
            ...widget.sharedExpense.participantsState.map(
              (e) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: ProfilePictureView(
                  person: e,
                  size: 30,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => SharedExpensePeoplePickerDialog(
                      people: [...cubit.group.people],
                      onRemove: () {
                        cubit.groupExpense
                            .removeSharedExpense(widget.sharedExpense);
                      },
                      sharedExpense: widget.sharedExpense),
                );
                cubit.onExpensesUpdated();
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
