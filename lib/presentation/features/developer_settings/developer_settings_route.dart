import 'package:billsplit_flutter/presentation/features/developer_settings/developer_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/developer_settings/developer_settings_route.g.dart';

@TypedGoRoute<DeveloperSettingsRoute>(path: "/developer-settings")
class DeveloperSettingsRoute extends GoRouteData with $DeveloperSettingsRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DeveloperSettingsPage();
  }
}
