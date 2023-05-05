import 'package:billsplit_flutter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseProvider {
  late final FirebaseApp firebaseApp;

  Future init() async {
    firebaseApp = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}
