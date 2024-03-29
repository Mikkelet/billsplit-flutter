import 'package:billsplit_flutter/domain/use_cases/auth/sign_in_guest_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/sign_in_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/sign_in_with_apple_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/sign_in_with_google_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/sign_up_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';

class LandingCubit extends BaseCubit {
  final _signUpUseCase = SignUpWithEmailUseCase();
  final _signInUseCase = SignInWithEmailUseCase();
  final _signInWithGoogleUseCase = SignInWithGoogleUseCase();
  final _signInWithAppleUseCase = SignInWithAppleUseCase();
  final _signInAsGuest = SignInGuestUseCase();

  void signUpWithEmail(String email, String password) async {
    showLoading();
    _signUpUseCase.launch(email, password).then((data) {
      emit(SignUpSuccessful());
    }).catchError((err, st) {
      showError(err, st);
      emit(Main());
    });
  }

  void signInWithEmail(String email, String password) async {
    showLoading();
    _signInUseCase.launch(email, password).then((data) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
      emit(Main());
    });
  }

  void signInWithGoogle() {
    emit(Loading());
    _signInWithGoogleUseCase.launch().then((_) {
      emit(Main());
    }).catchError((err, st) {
      emit(Main());
      showError(err, st);
    });
  }

  void signInWithApple() {
    emit(Loading());
    _signInWithAppleUseCase.launch().then((_) {
      emit(Main());
    }).catchError((err, stackTrace) {
      emit(Main());
      showError(err, stackTrace);
    });
  }

  void signInAsGuest() {
    showLoading();
    _signInAsGuest.launch().then((value) {
      emit(SignUpAnonymously());
    }).catchError((err, st){
      emit(Main());
      showError(err, st);
    });
  }
}