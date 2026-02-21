import 'package:billsplit_flutter/presentation/features/friends/bloc/friends_cubit.dart';
import 'package:billsplit_flutter/presentation/features/friends/friends_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/app_router.dart';

part '../../../_generated/presentation/features/friends/friends_route.g.dart';

@TypedGoRoute<FriendsRoute>(path: AppRoutes.friends)
class FriendsRoute extends GoRouteData with $FriendsRoute {
  const FriendsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(create: (context) => FriendsCubit(), child: const FriendsPage());
  }
}
