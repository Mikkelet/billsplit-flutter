import 'dart:ui';

import 'package:billsplit_flutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseProvider {
  late final FirebaseApp firebaseApp;

  Future init() async {
    if (Firebase.apps.isEmpty) {
      firebaseApp = await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    }
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
}
