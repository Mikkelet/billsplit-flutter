import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/group_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/group/group_route.g.dart';

@TypedGoRoute<GroupRoute>(path: '/group/:id')
class GroupRoute extends GoRouteData with $GroupRoute {
  final String id;

  const GroupRoute(this.id);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => GroupBloc(id),
      child: GroupPage(),
    );
  }
}
