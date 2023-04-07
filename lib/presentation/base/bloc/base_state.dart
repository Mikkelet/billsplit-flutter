abstract class BaseState {}

class Main extends BaseState {}

class Loading extends BaseState {}

class Failure extends BaseState {
  final Exception error;

  Failure(this.error);
}
