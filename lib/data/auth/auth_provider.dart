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
    if (user == null) return "";
    final token = await user.getIdToken(refresh);
    return token ?? "";
  }

  Stream<User?> authListener() {
    return _firebaseAuth.userChanges();
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future updateProfilePicture(String? downloadUrl) async {
    await _firebaseAuth.currentUser!.updatePhotoURL(downloadUrl);
  }

  Future updateUserName(String name) async {
    await _firebaseAuth.currentUser!.updateDisplayName(name);
  }

  Future forgotPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updatePhoneNumber(
      {required String phoneNumber,
      required Function(UiException e) onFailed,
      required Function(String verificationId) onCodeSent}) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(minutes: 2),
      verificationCompleted: (credential) async {
        await _firebaseAuth.currentUser!.updatePhoneNumber(credential);
      },
      verificationFailed: (e) {
        onFailed(e.toUiException());
      },
      codeSent: (verificationId, forceResendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<void> submitSmsCode(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await _firebaseAuth.currentUser!.updatePhoneNumber(credential);
  }

  deleteUser() {
    _firebaseAuth.currentUser?.delete();
  }
}
