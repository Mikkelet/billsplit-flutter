sealed class SplitsbyError {
  const SplitsbyError();

  static SplitsbyError serverError(String message) => ServerError(message);

  const factory SplitsbyError.none() = None;
}

final class None extends SplitsbyError {
  const None() : super();
}

final class ServerError extends SplitsbyError {
  final String message;

  const ServerError(this.message) : super();
}
