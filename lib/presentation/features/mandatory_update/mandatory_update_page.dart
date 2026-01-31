import 'dart:io';

import 'package:billsplit_flutter/domain/models/app_version.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class MandatoryUpdatePage extends StatelessWidget {
  final AppVersion appVersion;

  const MandatoryUpdatePage({super.key, required this.appVersion});

  @override
  Widget build(BuildContext context) {
    final String appUpdaterName =
        Platform.isAndroid ? "App Tester" : "TestFlight";
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Column(
              children: [
                const SizedBox(height: 64),
                Text("Please update your app",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 32),
                Text(
                    "A new mandatory update has been released. Please go to $appUpdaterName and update Splitsby.",
                    style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 16),
                Text(
                    "minVersion=${appVersion.minimumVersion}, currentVersion=${appVersion.currentVersion}",
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        ),
      ),
    );
  }


  static String routeName = "mandatory_update";

  static Route getRoute(AppVersion appVersion) =>
      slideUpRoute(MandatoryUpdatePage(appVersion: appVersion), routeName: routeName);
}
