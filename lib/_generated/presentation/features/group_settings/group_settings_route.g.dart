// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/group_settings/group_settings_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$groupSettingsRoute];

RouteBase get $groupSettingsRoute => GoRouteData.$route(
  path: '/group-settings',
  factory: $GroupSettingsRoute._fromState,
);

mixin $GroupSettingsRoute on GoRouteData {
  static GroupSettingsRoute _fromState(GoRouterState state) =>
      GroupSettingsRoute(state.extra as Group);

  GroupSettingsRoute get _self => this as GroupSettingsRoute;

  @override
  String get location => GoRouteData.$location('/group-settings');

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
