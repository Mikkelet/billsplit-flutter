import 'package:billsplit_flutter/presentation/features/inspect_profile/bloc/inspect_profile_cubit.dart';
import 'package:billsplit_flutter/presentation/features/inspect_profile/inspect_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/person.dart';

part '../../../_generated/presentation/features/inspect_profile/inspect_profile_route.g.dart';

@TypedGoRoute<InspectProfileRoute>(path: "/inspect-profile")
class InspectProfileRoute extends GoRouteData with $InspectProfileRoute {
  final Person $extra;

  const InspectProfileRoute(this.$extra);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: BlocProvider(
        create: (context) => InspectProfileCubit($extra),
        child: InspectProfilePage(),
      ),
    );
  }
}
