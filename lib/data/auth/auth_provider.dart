import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:billsplit_flutter/firebase_options.dart';

class AuthProvider {
  late final FirebaseApp _firebaseApp;
  late final FirebaseAuth _firebaseAuth;

  Person? _user;

  Future init() async {
    if (Firebase.apps.isEmpty) {
      _firebaseApp = await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    } else {
      _firebaseApp = Firebase.app();
    }

    _firebaseAuth = FirebaseAuth.instanceFor(app: _firebaseApp);
  }

  Future signInWithEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<String> getToken(bool refresh) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return "";
    return await user.getIdToken(refresh);
  }

  Stream<String?> authListener() {
    return _firebaseAuth.userChanges().map((event) {
      _user = event == null
          ? null
          : Person(event.uid, event.displayName!, event.photoURL!);
      return event?.uid;
    });
  }

  Person? get user => _user;
}
