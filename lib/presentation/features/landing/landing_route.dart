import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_cubit.dart';
import 'package:billsplit_flutter/presentation/features/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/app_router.dart';

part '../../../_generated/presentation/features/landing/landing_route.g.dart';

@TypedGoRoute<LandingRoute>(path: AppRoutes.landing)
class LandingRoute extends GoRouteData with $LandingRoute {
  const LandingRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: BlocProvider(
        create: (context) => LandingCubit(),
        child: LandingPage(),
      ),
    );
  }
}
