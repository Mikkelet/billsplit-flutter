import 'package:billsplit_flutter/presentation/features/group_invites/bloc/group_invite_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group_invites/group_invites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/group_invites/group_invites_route.g.dart';

@TypedGoRoute<GroupInvitesRoute>(path: '/group-invites')
class GroupInvitesRoute extends GoRouteData with $GroupInvitesRoute {
  final String? phoneNumber;

  const GroupInvitesRoute({this.phoneNumber});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => GroupInvitesCubit(),
      child: GroupInvitesPage(),
    );
  }
}
