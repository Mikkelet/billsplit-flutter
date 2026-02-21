// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/landing/landing_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$landingRoute];

RouteBase get $landingRoute =>
    GoRouteData.$route(path: '/landing', factory: $LandingRoute._fromState);

mixin $LandingRoute on GoRouteData {
  static LandingRoute _fromState(GoRouterState state) => const LandingRoute();

  @override
  String get location => GoRouteData.$location('/landing');

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
