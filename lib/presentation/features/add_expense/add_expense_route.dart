import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/expense_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/add_expense/add_expense_route.g.dart';

@TypedGoRoute<AddExpenseRoute>(path: "/groups/:groupId/expense/:expenseId")
class AddExpenseRoute extends GoRouteData with $AddExpenseRoute {
  final String groupId;
  final String expenseId;

  const AddExpenseRoute({required this.groupId, required this.expenseId});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: BlocProvider(
        create: (context) => AddExpenseBloc(
          getIt.get(),
          groupId: groupId,
          groupExpenseId: expenseId,
        ),
        child: AddExpensePage(),
      ),
    );
  }
}
