// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/group_invites/group_invites_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$groupInvitesRoute];

RouteBase get $groupInvitesRoute => GoRouteData.$route(
  path: '/group-invites',
  factory: $GroupInvitesRoute._fromState,
);

mixin $GroupInvitesRoute on GoRouteData {
  static GroupInvitesRoute _fromState(GoRouterState state) =>
      GroupInvitesRoute(phoneNumber: state.uri.queryParameters['phone-number']);

  GroupInvitesRoute get _self => this as GroupInvitesRoute;

  @override
  String get location => GoRouteData.$location(
    '/group-invites',
    queryParams: {
      if (_self.phoneNumber != null) 'phone-number': _self.phoneNumber,
    },
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
