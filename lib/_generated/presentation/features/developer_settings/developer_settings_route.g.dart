// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/developer_settings/developer_settings_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$developerSettingsRoute];

RouteBase get $developerSettingsRoute => GoRouteData.$route(
  path: '/developer-settings',
  factory: $DeveloperSettingsRoute._fromState,
);

mixin $DeveloperSettingsRoute on GoRouteData {
  static DeveloperSettingsRoute _fromState(GoRouterState state) =>
      DeveloperSettingsRoute();

  @override
  String get location => GoRouteData.$location('/developer-settings');

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
