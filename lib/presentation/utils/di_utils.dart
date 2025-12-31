import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

extension DiUtils on BuildContext {
  Person get user => getIt<AuthRepository>().loggedInUser;
}
