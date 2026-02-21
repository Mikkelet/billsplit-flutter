import 'package:billsplit_flutter/presentation/features/profile/profile_page.dart';
import 'package:billsplit_flutter/presentation/navigation/transitions/slide_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/app_router.dart';

part '../../../_generated/presentation/features/profile/profile_route.g.dart';

@TypedGoRoute<ProfileRoute>(path: AppRoutes.profile)
class ProfileRoute extends GoRouteData with $ProfileRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return SlideInTransition(
      state: state,
      child: ProfilePage(),
    );
  }
}
