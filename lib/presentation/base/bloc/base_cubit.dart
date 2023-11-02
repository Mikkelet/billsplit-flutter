import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit extends Cubit<UiState> {
  final authProvider = getIt<AuthProvider>();
  final _authRepository = getIt<AuthRepository>();
  final sharedPrefs = getIt<SharedPrefs>();

  BaseCubit() : super(Main());

  BaseCubit.withState(super.initialState) : super();

  void update() {
    emit(Main());
  }

  void showLoading() {
    emit(Loading());
  }

  @override
  void emit(UiState state) {
    if (isClosed) return;
    super.emit(state);
  }

  void showError(dynamic err, StackTrace? stackTrace) {
    FirebaseCrashlytics.instance.log("error=$err, stackTrace=$stackTrace");
    if (err is Error) {
      debugPrint("qqq err: $err");
      debugPrintStack(stackTrace: stackTrace);
      emit(Failure(UiException(-1, err.toString())));
    } else if (err is UiException) {
      emit(Failure(err));
    } else if (err is FirebaseAuthException) {
      if (err.code == "unknown") {
        emit(Failure(UiException(1001, "Enter a valid email")));
      } else if (err.code == "user-not-found") {
        emit(Failure(UiException(1002, "Email not found")));
      } else {
        emit(Failure(UiException(1000, "${err.message}")));
      }
    } else if (err is Exception) {
      debugPrint("qqq err: $err");
      debugPrintStack(stackTrace: stackTrace);
      emit(Failure(err.toUiException()));
    } else {
      print("qqq err: ${err.runtimeType.toString()}");
      emit(Failure(UiException(-1, "${err.runtimeType}: $err")));
    }
  }

  Person get user => _authRepository.loggedInUser;

  void showToast(String message) {
    emit(ShowToast(message));
  }
}
