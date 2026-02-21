// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/permissions/notification_rationale_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$notificationRationaleRoute];

RouteBase get $notificationRationaleRoute => GoRouteData.$route(
  path: '/notification-rationale',
  factory: $NotificationRationaleRoute._fromState,
);

mixin $NotificationRationaleRoute on GoRouteData {
  static NotificationRationaleRoute _fromState(GoRouterState state) =>
      NotificationRationaleRoute();

  @override
  String get location => GoRouteData.$location('/notification-rationale');

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
