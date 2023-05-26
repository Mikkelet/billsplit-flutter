import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';

abstract class UiState {}

class Main extends UiState {}

class Loading extends UiState {}

class Failure extends UiState {
  final UiException error;

  Failure(this.error);
}

class ShowToast extends UiState {
  final String message;

  ShowToast(this.message);
}
