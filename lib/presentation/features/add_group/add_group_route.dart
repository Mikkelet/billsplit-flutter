import 'package:billsplit_flutter/presentation/features/add_group/add_group_page.dart';
import 'package:billsplit_flutter/presentation/features/add_group/bloc/add_group_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/add_group/add_group_route.g.dart';

@TypedGoRoute<AddGroupRoute>(path: "/add-groupe")
class AddGroupRoute extends GoRouteData with $AddGroupRoute {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: BlocProvider(
        create: (context) => AddGroupCubit(),
        child: AddGroupPage(),
      ),
    );
  }
}
