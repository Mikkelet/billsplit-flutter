import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescriptionTextField extends StatefulWidget {
  final String initialText;

  const DescriptionTextField({Key? key, required this.initialText})
      : super(key: key);

  @override
  State<DescriptionTextField> createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends SafeState<DescriptionTextField> {
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
      height: 64,
      padding: EdgeInsets.zero,
      child: TextField(
        controller: textController,
        textInputAction: TextInputAction.next,
        maxLines: 1,
        maxLength: 30,
        style: SplitsbyTextTheme.textFieldStyle(context),
        onChanged: (value) {
          cubit.groupExpense.descriptionState = value;
          cubit.onExpensesUpdated();
        },
        decoration: InputDecoration(
            counterText: "",
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            hintStyle: SplitsbyTextTheme.textFieldHintStyle(context),
            border: InputBorder.none,
            isDense: true,
            hintText:
                "Enter a description"),
      ),
    );
  }
}
