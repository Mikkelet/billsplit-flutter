import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationsRationale extends StatefulWidget {
  const NotificationsRationale({super.key});

  @override
  State<NotificationsRationale> createState() => _NotificationsRationaleState();

  static getRoute() =>
      MaterialPageRoute(builder: (context) => const NotificationsRationale());
}

class _NotificationsRationaleState extends SafeState<NotificationsRationale> {
  AuthorizationStatus? permissionStatus;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .requestPermission(announcement: false)
        .then((value) => {
          setPermissionDecided(value.authorizationStatus)
        });
  }

  void setPermissionDecided(AuthorizationStatus status) {
    setState(() {
      permissionStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefs = getIt<SharedPrefs>();
    prefs.hasSeenPushNotificationPermissionRationale = true;
    return BaseScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    "To keep up with the latest expenses, we would need your permission to send you notifications!",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 32),
                if (permissionStatus == AuthorizationStatus.authorized)
                  const Text("Notifications are allowed. You're all set!",
                      style: TextStyle(color: Colors.green))
                else
                  const Text("Notifications are currently blocked",
                      style: TextStyle(color: Colors.red)),
                if (permissionStatus != AuthorizationStatus.authorized)
                  const SizedBox(height: 32),
                if (permissionStatus != AuthorizationStatus.authorized)
                  SimpleButton(onClick: () async {
                    prefs.hasSeenPushNotificationPermissionRationale = true;
                    final permission =
                        await FirebaseMessaging.instance.requestPermission(
                      announcement: true,
                    );
                    setPermissionDecided(permission.authorizationStatus);
                  }, child: Builder(builder: (context) {
                    final text = permissionStatus == null
                        ? "Request permission"
                        : "I changed my mind";
                    return Text(text);
                  })),
                const SizedBox(height: 32),
                if (permissionStatus != null)
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.check))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
