// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/inspect_profile/inspect_profile_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$inspectProfileRoute];

RouteBase get $inspectProfileRoute => GoRouteData.$route(
  path: '/inspect-profile',
  factory: $InspectProfileRoute._fromState,
);

mixin $InspectProfileRoute on GoRouteData {
  static InspectProfileRoute _fromState(GoRouterState state) =>
      InspectProfileRoute(state.extra as Person);

  InspectProfileRoute get _self => this as InspectProfileRoute;

  @override
  String get location => GoRouteData.$location('/inspect-profile');

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
