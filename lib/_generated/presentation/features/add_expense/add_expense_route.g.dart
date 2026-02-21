// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/add_expense/add_expense_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$addExpenseRoute];

RouteBase get $addExpenseRoute => GoRouteData.$route(
  path: '/groups/:groupId/expense/:expenseId',
  factory: $AddExpenseRoute._fromState,
);

mixin $AddExpenseRoute on GoRouteData {
  static AddExpenseRoute _fromState(GoRouterState state) => AddExpenseRoute(
    groupId: state.pathParameters['groupId']!,
    expenseId: state.pathParameters['expenseId']!,
  );

  AddExpenseRoute get _self => this as AddExpenseRoute;

  @override
  String get location => GoRouteData.$location(
    '/groups/${Uri.encodeComponent(_self.groupId)}/expense/${Uri.encodeComponent(_self.expenseId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
