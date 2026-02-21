// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/add_service/add_service_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$addServiceRoute];

RouteBase get $addServiceRoute => GoRouteData.$route(
  path: '/groups/:groupId/service/:serviceId',
  factory: $AddServiceRoute._fromState,
);

mixin $AddServiceRoute on GoRouteData {
  static AddServiceRoute _fromState(GoRouterState state) => AddServiceRoute(
    state.pathParameters['groupId']!,
    state.pathParameters['serviceId']!,
  );

  AddServiceRoute get _self => this as AddServiceRoute;

  @override
  String get location => GoRouteData.$location(
    '/groups/${Uri.encodeComponent(_self.groupId)}/service/${Uri.encodeComponent(_self.serviceId)}',
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
