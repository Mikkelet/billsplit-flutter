abstract class Response<T> {
  final T data;
  final Exception? error;

  Response(this.data, this.error);
}

class Success<T> extends Response<T> {
  Success(T data) : super(data, null);
}

class Failure extends Response {
  Failure(Exception error) : super(null, error);
}

extension FutureExt on Future {
  Future<Response> execute<T>() async {
    try {
      final T data = await this;
      return Success(data);
    } on Exception catch (err, _) {
      return Failure(err);
    }
  }
}

extension ResponseExt on Response {
  void foldResponse<T>(
      {required Function(T data) onSuccess,
      required Function(Exception error) onFailure}) {
    if (this is Success) {
      onSuccess(data);
    } else if (this is Failure) {
      onFailure(error!);
    } else {
      throw Exception("Response is not valid subclass, is $runtimeType");
    }
  }
}
