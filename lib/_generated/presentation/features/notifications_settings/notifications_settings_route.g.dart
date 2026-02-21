// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/notifications_settings/notifications_settings_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$notificationsSettingsRoute];

RouteBase get $notificationsSettingsRoute => GoRouteData.$route(
  path: '/notification-settings',
  factory: $NotificationsSettingsRoute._fromState,
);

mixin $NotificationsSettingsRoute on GoRouteData {
  static NotificationsSettingsRoute _fromState(GoRouterState state) =>
      NotificationsSettingsRoute(state.extra as Group);

  NotificationsSettingsRoute get _self => this as NotificationsSettingsRoute;

  @override
  String get location => GoRouteData.$location('/notification-settings');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}
