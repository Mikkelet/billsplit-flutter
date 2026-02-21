import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/bloc/currency_picker_cubit.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/currency_picker/currency_picker_route.g.dart';

@TypedGoRoute<CurrencyPickerRoute>(path: "/select-currency")
class CurrencyPickerRoute extends GoRouteData with $CurrencyPickerRoute {
  final String? convertToCurrency;

  const CurrencyPickerRoute({this.convertToCurrency});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: BlocProvider(
        create: (context) => CurrencyPickerCubit(
          getIt.get(),
          convertToCurrency: convertToCurrency,
        ),
        child: CurrencyPickerDialog(),
      ),
    );
  }
}
