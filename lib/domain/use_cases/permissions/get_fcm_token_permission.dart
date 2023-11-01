import 'package:firebase_messaging/firebase_messaging.dart';

class GetNotificationPermission {
  Future<AuthorizationStatus> launch() async {
    final permission =
        await FirebaseMessaging.instance.getNotificationSettings();
    return permission.authorizationStatus;
  }
}
