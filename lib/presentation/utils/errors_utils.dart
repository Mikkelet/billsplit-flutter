import 'dart:convert';

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


const JsonDecoder decoder = JsonDecoder();
const JsonEncoder encoder = JsonEncoder.withIndent('  ');

void prettyPrintJson(String input) {
  var object = decoder.convert(input);
  var prettyString = encoder.convert(object);
  prettyString.split('\n').forEach((element) => print(element));
}
