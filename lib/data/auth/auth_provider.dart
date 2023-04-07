import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:billsplit_flutter/firebase_options.dart';

class AuthProvider {
  static final AuthProvider instance = AuthProvider();
  late final FirebaseApp _firebaseApp;
  late final FirebaseAuth _firebaseAuth;

  Future init() async {
    if (Firebase.apps.isEmpty) {
      _firebaseApp =
          await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    } else {
      _firebaseApp = Firebase.app();
    }

    _firebaseAuth = FirebaseAuth.instanceFor(app: _firebaseApp);
  }

  Future signInWithEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<String> getToken() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return "";
    return await user.getIdToken();
  }

  Stream<String?> authListener() {
    return _firebaseAuth.userChanges().map((event) => event?.uid);
  }
}
