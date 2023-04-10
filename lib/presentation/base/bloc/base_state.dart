abstract class UiState {}

class Main extends UiState {}

class Loading extends UiState {}

class Failure extends UiState {
  final Exception error;

  Failure(this.error);
}
