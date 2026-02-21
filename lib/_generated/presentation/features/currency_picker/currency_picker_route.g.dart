// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/currency_picker/currency_picker_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$currencyPickerRoute];

RouteBase get $currencyPickerRoute => GoRouteData.$route(
  path: '/select-currency',
  factory: $CurrencyPickerRoute._fromState,
);

mixin $CurrencyPickerRoute on GoRouteData {
  static CurrencyPickerRoute _fromState(GoRouterState state) =>
      CurrencyPickerRoute(
        convertToCurrency: state.uri.queryParameters['convert-to-currency'],
      );

  CurrencyPickerRoute get _self => this as CurrencyPickerRoute;

  @override
  String get location => GoRouteData.$location(
    '/select-currency',
    queryParams: {
      if (_self.convertToCurrency != null)
        'convert-to-currency': _self.convertToCurrency,
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
