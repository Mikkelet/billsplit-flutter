import 'package:billsplit_flutter/domain/use_cases/scan_receipt_usecase.dart';
import 'package:billsplit_flutter/presentation/common/camera/scan_receipt_view.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanReceiptButton extends StatelessWidget {
  const ScanReceiptButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return ClickableListItem(
        padding: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
        height: 48,
        width: 48,
        onClick: () async {
          if (!cubit.sharedPrefs.hasSeenScannerDisclaimer) {
            cubit.sharedPrefs.hasSeenScannerDisclaimer = true;
            await showDialog(
                context: context,
                builder: (context) => const CustomDialog(
                      title: "Experimental feature",
                      text:
                          "This feature is currently is BETA, and will not work with all receipts! \n"
                          "However, I would still like your feedback on your general experience!",
                    ));
          }
          if (context.mounted) {
            final response =
                await Navigator.of(context).push(SplitsbyCamera.getRoute());
            if (response is List<ScannedReceiptItem>) {
              cubit.uploadReceipt(response);
            }
          }
        },
        child: const Icon(Icons.document_scanner_outlined));
  }
}
