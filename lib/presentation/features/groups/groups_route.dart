import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/features/groups/groups_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/groups_bloc.dart';

part '../../../_generated/presentation/features/groups/groups_route.g.dart';

@TypedGoRoute<GroupsRoute>(path: "/groups")
class GroupsRoute extends GoRouteData with $GroupsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => GroupsBloc(getIt.get()),
      child: GroupsPage(),
    );
  }
}
