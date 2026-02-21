sealed class SplitsbyError {
  const SplitsbyError();

  static SplitsbyError serverError(String message) => ServerError(message);

  const factory SplitsbyError.none() = None;

  factory SplitsbyError.unknown(String message) => UnknownError(message);
}

final class None extends SplitsbyError {
  const None() : super();
}

final class ServerError extends SplitsbyError {
  final String message;

  const ServerError(this.message) : super();
}

final class UnknownError extends SplitsbyError {
  final String message;

  const UnknownError(this.message) : super();
}
