import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseCubit extends Cubit<UiState> {
  @protected
  final authRepository = getIt<AuthRepository>();
  final sharedPrefs = getIt<SharedPrefs>();

  final compositeSubscription = CompositeSubscription();

  final loading = false.obs();

  BaseCubit() : super(Main());

  BaseCubit.withState(super.initialState) : super();

  void update() {
    loading.value = false;
    emit(Main());
  }

  void showLoading() {
    loading.value = true;
    emit(Loading());
  }

  @override
  void emit(UiState state) {
    if (isClosed) return;
    if (state is Main) {
      super.emit(state);
    } else if (this.state != state) {
      super.emit(state);
    }
  }

  void showError(dynamic err, StackTrace? stackTrace) {
    if (err is Error) {
      debugPrint("qqq err: $err");
      debugPrintStack(stackTrace: stackTrace);
      emit(Failure(UiException(-1, err.toString())));
    } else if (err is UiException) {
      emit(Failure(err));
    } else if (err is ClientException) {
      emit(Failure(UiException(
          1003, "Failed to connect to server. Check your internet.")));
    } else if (err is FirebaseAuthException) {
      if (err.code == "unknown") {
        emit(Failure(UiException(1001, "Enter a valid email")));
      } else if (err.code == "user-not-found") {
        emit(Failure(UiException(1002, "Email not found")));
      } else {
        emit(Failure(UiException(1000, "${err.message}")));
        if (!kDebugMode) {
          FirebaseCrashlytics.instance.recordError(err, stackTrace);
        }
      }
    } else if (err is Exception) {
      debugPrint("qqq err: $err");
      debugPrintStack(stackTrace: stackTrace);
      emit(Failure(err.toUiException()));
      if (!kDebugMode) {
        FirebaseCrashlytics.instance.recordError(err, stackTrace);
      }
    } else {
      print("qqq err: ${err.runtimeType.toString()}");
      emit(Failure(UiException(-1, "${err.runtimeType}: $err")));
      if (!kDebugMode) {
        FirebaseCrashlytics.instance.recordError(err, stackTrace);
      }
    }
  }

  Person get user => authRepository.loggedInUser;

  void showToast(String message) {
    emit(ShowToast(message));
  }

  @override
  Future<void> close() {
    compositeSubscription.dispose();
    return super.close();
  }
}
