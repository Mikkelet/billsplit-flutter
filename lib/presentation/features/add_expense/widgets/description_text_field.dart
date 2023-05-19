import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescriptionTextField extends StatefulWidget {
  final String initialText;

  const DescriptionTextField({Key? key, required this.initialText})
      : super(key: key);

  @override
  State<DescriptionTextField> createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  late final textController = TextEditingController(text: widget.initialText);

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return RoundedListItem(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(10),
        bottom: Radius.circular(10),
      ),
      child: TextField(
        controller: textController,
        textInputAction: TextInputAction.next,
        maxLines: 1,
        maxLength: 30,
        onChanged: (value) {
          cubit.groupExpense.descriptionState = value;
          cubit.onExpensesUpdated();
        },
        decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
            hintText:
                "Eg. restaurant, groceries"),
      ),
    );
  }
}
