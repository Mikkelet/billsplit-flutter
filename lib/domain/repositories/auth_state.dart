import 'package:billsplit_flutter/domain/models/person.dart';

class AuthState {}

class LoggedInState extends AuthState {
  final Person user;

  LoggedInState(this.user);
}

class LoadingUserState extends AuthState {}

class LoggedOutState extends AuthState {}
