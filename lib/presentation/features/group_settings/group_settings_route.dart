import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/group_settings_page.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/group_settings/group_settings_route.g.dart';

@TypedGoRoute<GroupSettingsRoute>(path: '/group-settings')
class GroupSettingsRoute extends GoRouteData with $GroupSettingsRoute {
  
  final Group $extra;

  const GroupSettingsRoute(this.$extra);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => GroupSettingsCubit($extra),
      child: GroupSettings(),
    );
  }
}
