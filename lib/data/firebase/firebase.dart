import 'package:billsplit_flutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseProvider {
  late final FirebaseApp firebaseApp;

  Future init() async {
    if (Firebase.apps.isEmpty) {
      firebaseApp = await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    } else {
      firebaseApp = Firebase.app();
    }
  }
}
