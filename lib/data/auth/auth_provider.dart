import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthProvider {
  late final FirebaseApp _firebaseApp;
  late final FirebaseAuth _firebaseAuth;

  void init() async {
    _firebaseApp = await Firebase.initializeApp();
    _firebaseAuth = FirebaseAuth.instanceFor(app: _firebaseApp);
  }

  Future signInWithEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Stream<String?> authListener() {
    return _firebaseAuth.userChanges().map((event) => event?.uid);
  }
}
