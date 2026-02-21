import 'package:billsplit_flutter/presentation/features/permissions/notifications_rationale.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/permissions/notification_rationale_route.g.dart';

@TypedGoRoute<NotificationRationaleRoute>(path: "/notification-rationale")
class NotificationRationaleRoute extends GoRouteData with $NotificationRationaleRoute {

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: NotificationsRationale(),
    );
  }
}
