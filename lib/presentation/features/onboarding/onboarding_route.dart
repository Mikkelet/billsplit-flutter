import 'package:billsplit_flutter/presentation/features/onboarding/onboarding_flow.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/onboarding/onboarding_route.g.dart';

@TypedGoRoute<OnboardingRoute>(path: "/onboarding")
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(child: OnboardingFlow());
  }
}
