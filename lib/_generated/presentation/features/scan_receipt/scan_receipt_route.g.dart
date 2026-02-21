// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../presentation/features/scan_receipt/scan_receipt_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$scanReceiptRoute];

RouteBase get $scanReceiptRoute => GoRouteData.$route(
  path: '/scan-receipt',
  factory: $ScanReceiptRoute._fromState,
);

mixin $ScanReceiptRoute on GoRouteData {
  static ScanReceiptRoute _fromState(GoRouterState state) => ScanReceiptRoute();

  @override
  String get location => GoRouteData.$location('/scan-receipt');

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
