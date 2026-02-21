import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/features/notifications_settings/bloc/notification_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/features/notifications_settings/bloc/notification_topics.dart';
import 'package:billsplit_flutter/presentation/features/notifications_settings/notifications_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/notifications_settings/notifications_settings_route.g.dart';

@TypedGoRoute<NotificationsSettingsRoute>(path: "/notification-settings")
class NotificationsSettingsRoute extends GoRouteData with $NotificationsSettingsRoute {
  final Group $extra;

  const NotificationsSettingsRoute(this.$extra);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: BlocProvider(
        create: (context) =>
            NotificationSettingsCubit(getIt.get(), NotificationTopic.newExpense, $extra),
        child: NotificationsSettingsView(),
      ),
    );
  }
}
