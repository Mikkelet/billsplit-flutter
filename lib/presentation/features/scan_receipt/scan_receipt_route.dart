import 'package:billsplit_flutter/presentation/features/scan_receipt/bloc/scan_receipt_cubit.dart';
import 'package:billsplit_flutter/presentation/features/scan_receipt/scan_receipt_view.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/scan_receipt/scan_receipt_route.g.dart';

@TypedGoRoute<ScanReceiptRoute>(path: "/scan-receipt")
class ScanReceiptRoute extends GoRouteData with $ScanReceiptRoute {

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: BlocProvider(
        create: (context) => ScanReceiptCubit(),
        child: SplitsbyCamera(),
      ),
    );
  }
}
