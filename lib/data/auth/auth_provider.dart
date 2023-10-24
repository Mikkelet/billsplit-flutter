import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthProvider {
  static const _googleSignInScopes = ["email"];
  static const _appleSignInScopes = [
    AppleIDAuthorizationScopes.email,
    AppleIDAuthorizationScopes.fullName,
  ];

  late final FirebaseAuth _firebaseAuth;

  Person? _user;

  Future init(FirebaseApp firebaseApp) async {
    _firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
  }

  Future signInWithEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(scopes: _googleSignInScopes);
    final googleSignInAccount = await googleSignIn.signIn();

    final auth = await googleSignInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signInWithApple() async {
    final appleIDCredential =
        await SignInWithApple.getAppleIDCredential(scopes: _appleSignInScopes);
    final credential = OAuthProvider('apple.com').credential(
      idToken: appleIDCredential.identityToken,
      accessToken: appleIDCredential.authorizationCode,
    );
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future signUpWithEmail(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<String> getToken(bool refresh) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw UiException(404, "User not logged in");
    final token = await user.getIdToken(refresh);
    return token ?? "";
  }

  Stream<String?> authListener() {
    return _firebaseAuth.userChanges().map((event) {
      _user = event == null
          ? null
          : Person(event.uid, event.displayName ?? "",
              pfpUrl: event.photoURL ?? "", email: event.email ?? "");
      return _user?.uid;
    });
  }

  Person get user {
    if (_user == null) throw Exception("User not found");
    return _user!;
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future updateProfilePicture(String? downloadUrl) async {
    await _firebaseAuth.currentUser!.updatePhotoURL(downloadUrl);
  }

  Future updateUserName(String name) async {
    await _firebaseAuth.currentUser!.updateDisplayName(name);
    _user?.nameState = name;
  }

  Future forgotPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
