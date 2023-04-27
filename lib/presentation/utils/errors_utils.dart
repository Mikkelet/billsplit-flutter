import 'package:firebase_auth/firebase_auth.dart';

class UiException implements Exception {
  final int errorCode;
  final String message;

  UiException(this.errorCode, this.message);

  @override
  String toString() {
    return "[$errorCode] $message";
  }
}

class NoInternetException extends UiException {
  NoInternetException() : super(0, "Missing internet");
}

extension ExceptionExt on Exception {
  UiException toUiException() {
    switch (runtimeType) {
      case FirebaseAuthException:
      default:
        return UiException(0, "$runtimeType: $this");
    }
  }
}
