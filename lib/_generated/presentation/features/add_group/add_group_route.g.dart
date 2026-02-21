// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/add_group/add_group_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$addGroupRoute];

RouteBase get $addGroupRoute =>
    GoRouteData.$route(path: '/add-groupe', factory: $AddGroupRoute._fromState);

mixin $AddGroupRoute on GoRouteData {
  static AddGroupRoute _fromState(GoRouterState state) => AddGroupRoute();

  @override
  String get location => GoRouteData.$location('/add-groupe');

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
