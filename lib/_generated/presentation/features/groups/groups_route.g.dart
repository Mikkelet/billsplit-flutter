// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/groups/groups_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$groupsRoute];

RouteBase get $groupsRoute =>
    GoRouteData.$route(path: '/groups', factory: $GroupsRoute._fromState);

mixin $GroupsRoute on GoRouteData {
  static GroupsRoute _fromState(GoRouterState state) => GroupsRoute();

  @override
  String get location => GoRouteData.$location('/groups');

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
