import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SharedExpenseDescriptionView extends StatelessWidget {
  final SharedExpense sharedExpense;
  final bool showIcon;
  final bool alignRight;
  final bool autoFocus;
  final String hintText;

  const SharedExpenseDescriptionView({
    super.key,
    required this.sharedExpense,
    required this.hintText,
    this.showIcon = false,
    this.alignRight = false,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelLarge;
    final cubit = context.read<AddExpenseBloc>();
    return TextField(
      controller: cubit.descriptionTextController,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: TextInputAction.next,
      textAlign: alignRight ? TextAlign.end : TextAlign.start,
      autofocus: autoFocus,
      maxLines: 1,
      maxLength: 20,
      style: style,
      decoration: InputDecoration(
        hintStyle: SplitsbyTextTheme.textFieldHintStyle(
          context,
        ).copyWith(fontSize: style?.fontSize),
        counterText: "",
        prefixIcon: showIcon
            ? const Padding(padding: EdgeInsets.only(right: 8), child: Icon(Icons.edit))
            : null,
        isDense: true,
        prefixIconConstraints: const BoxConstraints(),
        border: InputBorder.none,
        hintText: hintText,
      ),
    );
  }
}
