import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthState {}
class LoggedInState extends AuthState {
  final Person user;

  LoggedInState(this.user);
}
class LoadingUserState extends AuthState {}
class LoggedOutState extends AuthState {}


class AuthProvider {
  late final FirebaseAuth _firebaseAuth;

  Person? _user;
  AuthState authState = LoadingUserState();

  Future init(FirebaseApp firebaseApp) async {
    _firebaseAuth = FirebaseAuth.instanceFor(app: firebaseApp);
  }

  Future signInWithEmail(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future signUpWithEmail(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<String> getToken(bool refresh) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw UiException(404, "User not logged in");
    return await user.getIdToken(refresh);
  }

  Stream<AuthState> authListener() {
    return _firebaseAuth.userChanges().map((event) {
      if (event == null) {
        return LoggedOutState();
      }
      final user = Person(event.uid, event.displayName ?? "",
          pfpUrl: event.photoURL ?? "", email: event.email ?? "");
      _user = user;
      return LoggedInState(user);
    });
  }

  Person? get user => _user;

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
