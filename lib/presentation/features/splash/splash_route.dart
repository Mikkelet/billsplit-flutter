import 'package:billsplit_flutter/presentation/features/splash/bloc/splash_cubit.dart';
import 'package:billsplit_flutter/presentation/features/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/app_router.dart';

part '../../../_generated/presentation/features/splash/splash_route.g.dart';

@TypedGoRoute<SplashRoute>(path: AppRoutes.splash)
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: SplashPage(),
    );
  }
}
