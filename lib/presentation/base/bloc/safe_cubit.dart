import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SafeCubit<T> extends Cubit<T> {
  SafeCubit(super.initialState);

  void safeEmit(T state) {
    if (!isClosed) return;
    emit(state);
  }

  void logError(Object e, StackTrace st) {
    if (kDebugMode) {
      debugPrint("qqq err: $e");
      debugPrintStack(stackTrace: st);
    }
  }
}
