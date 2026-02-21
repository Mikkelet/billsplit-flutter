// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/update_phone_number/update_phone_number_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$updatePhoneNumberRoute];

RouteBase get $updatePhoneNumberRoute => GoRouteData.$route(
  path: '/update-phone-number',
  factory: $UpdatePhoneNumberRoute._fromState,
);

mixin $UpdatePhoneNumberRoute on GoRouteData {
  static UpdatePhoneNumberRoute _fromState(GoRouterState state) =>
      UpdatePhoneNumberRoute(
        phoneNumber: state.uri.queryParameters['phone-number'],
      );

  UpdatePhoneNumberRoute get _self => this as UpdatePhoneNumberRoute;

  @override
  String get location => GoRouteData.$location(
    '/update-phone-number',
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
