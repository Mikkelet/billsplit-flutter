// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/friends/friends_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$friendsRoute];

RouteBase get $friendsRoute =>
    GoRouteData.$route(path: '/', factory: $FriendsRoute._fromState);

mixin $FriendsRoute on GoRouteData {
  static FriendsRoute _fromState(GoRouterState state) => const FriendsRoute();

  @override
  String get location => GoRouteData.$location('/');

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
