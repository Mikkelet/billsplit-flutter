import 'package:billsplit_flutter/presentation/common/expense_textfield/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/expense_textfield_controller.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSurcharge extends StatefulWidget {
  const AddSurcharge({super.key, required this.initialValue});

  final num initialValue;

  @override
  State<AddSurcharge> createState() => _AddSurchargeState();
}

class _AddSurchargeState extends State<AddSurcharge> {
  late final ExpenseTextFieldController textFieldController =
      ExpenseTextFieldController(text: "${widget.initialValue}");

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return RoundedListItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Surcharge"),
          Row(
            children: [
              IconButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  return CustomDialog(
                    title: "Surcharge",
                    text: "Use this field to add a surcharge such as service charge or VAT. Each item in this bill will be increased by this charge as a percentage.",
                  );
                });
              }, icon: Icon(Icons.info_outline)),
              Flexible(
                child: ExpenseTextField(
                  textEditingController: textFieldController,
                  onChange: (value) {
                    cubit.onUpdateSurcharge(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
