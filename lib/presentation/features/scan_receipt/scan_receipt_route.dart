import 'package:billsplit_flutter/presentation/features/scan_receipt/bloc/scan_receipt_cubit.dart';
import 'package:billsplit_flutter/presentation/features/scan_receipt/scan_receipt_view.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ScanReceiptRoute {
  static Route getRoute() {
    final widget = BlocProvider(
      create: (context) => ScanReceiptCubit(),
      child: SplitsbyCamera(),
    );
    return slideUpRoute(widget);
  }
}
