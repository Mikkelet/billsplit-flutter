import 'package:billsplit_flutter/presentation/common/camera/splitsby_camera.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanReceiptButton extends StatelessWidget {
  const ScanReceiptButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return IconButton(
        onPressed: () async {
          final response =
              await Navigator.of(context).push(SplitsbyCamera.getRoute());
          if (response is XFile) {
            cubit.uploadReceipt(response.path);
          }
        },
        icon: const Icon(Icons.document_scanner_outlined));
  }
}
