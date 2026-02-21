// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/group/group_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$groupRoute];

RouteBase get $groupRoute =>
    GoRouteData.$route(path: '/group/:id', factory: $GroupRoute._fromState);

mixin $GroupRoute on GoRouteData {
  static GroupRoute _fromState(GoRouterState state) =>
      GroupRoute(state.pathParameters['id']!);

  GroupRoute get _self => this as GroupRoute;

  @override
  String get location =>
      GoRouteData.$location('/group/${Uri.encodeComponent(_self.id)}');

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
