import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationsRationale extends StatefulWidget {
  const NotificationsRationale({Key? key}) : super(key: key);

  @override
  State<NotificationsRationale> createState() => _NotificationsRationaleState();

  static getRoute() =>
      MaterialPageRoute(builder: (context) => const NotificationsRationale());
}

class _NotificationsRationaleState extends SafeState<NotificationsRationale> {
  AuthorizationStatus? permissionDecided;

  void setPermissionDecided(AuthorizationStatus status) {
    setState(() {
      permissionDecided = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefs = getIt<SharedPrefs>();
    prefs.hasSeenPushNotificationPermissionRationale = true;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                    "To keep up with the latest expenses, we would need your permission to send you notifications!"),
                const SizedBox(height: 32),
                if (permissionDecided == AuthorizationStatus.authorized)
                  const Text("Accepted!", style: TextStyle(color: Colors.green))
                else
                  const Text("Denied", style: TextStyle(color: Colors.red)),
                if (permissionDecided != AuthorizationStatus.authorized)
                  const SizedBox(height: 32),
                if (permissionDecided != AuthorizationStatus.authorized)
                  SimpleButton(onClick: () async {
                    prefs.hasSeenPushNotificationPermissionRationale = true;
                    final permission =
                        await FirebaseMessaging.instance.requestPermission(
                      announcement: true,
                    );
                    setPermissionDecided(permission.authorizationStatus);
                  }, child: Builder(builder: (context) {
                    final text = permissionDecided == null
                        ? "Request permission"
                        : "I changed my mind";
                    return Text(text);
                  })),
                const SizedBox(height: 32),
                if (permissionDecided != null) const BackButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
