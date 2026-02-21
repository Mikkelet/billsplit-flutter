import 'package:billsplit_flutter/domain/use_cases/auth/sign_in_guest_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/sign_in_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/sign_in_with_apple_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/sign_in_with_google_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/auth/sign_up_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../../../domain/use_cases/profile/forgot_password_usecase.dart';

class LandingCubit extends SafeCubit<LandingState> {
  final _signUpUseCase = SignUpWithEmailUseCase();
  final _signInUseCase = SignInWithEmailUseCase();
  final _signInWithGoogleUseCase = SignInWithGoogleUseCase();
  final _signInWithAppleUseCase = SignInWithAppleUseCase();
  final _signInAsGuest = SignInGuestUseCase();
  final _forgotPasswordUseCase = ForgotPasswordUseCase();

  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final repeatPasswordFieldController = TextEditingController();
  final pageController = PageController();

  LandingCubit() : super(const LandingState()) {
    init();
  }

  void init() async {
    emailFieldController.addListener(() {
      safeEmit(state.copyWith(emailError: ""));
    });
    passwordFieldController.addListener(() {
      safeEmit(state.copyWith(passwordError: ""));
    });
    repeatPasswordFieldController.addListener(() {
      safeEmit(state.copyWith(repeatPasswordError: ""));
    });
  }

  void signUpWithEmail() async {
    try {
      safeEmit(state.loading());
      final email = emailFieldController.text;
      final password = passwordFieldController.text;
      await _signUpUseCase.launch(email, password);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void signInWithEmail() async {
    try {
      safeEmit(state.loading());
      final String email = emailFieldController.text;
      final String password = passwordFieldController.text;
      await _signInUseCase.launch(email, password);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void signInWithGoogle() async {
    try {
      safeEmit(state.loading());
      await _signInWithGoogleUseCase.launch();
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void signInWithApple() async {
    try {
      safeEmit(state.loading());
      await _signInWithAppleUseCase.launch();
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void signInAsGuest() async {
    try {
      safeEmit(state.loading());
      await _signInAsGuest.launch();
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void forgotPassword(String email) async {
    try {
      safeEmit(state.loading());
      await _forgotPasswordUseCase.launch(email);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  bool validateFields() {
    validateEmail();
    validatePassword();
    validateRepeatPassword();
    return state.emailError.isEmpty &&
        state.passwordError.isEmpty &&
        state.repeatPasswordError.isEmpty;
  }

  void validateEmail() {
    final String emailError;
    if (emailFieldController.text.isEmpty) {
      emailError = "Enter email";
    } else if (!EmailValidator.validate(emailFieldController.text)) {
      emailError = "Invalid email";
    } else {
      emailError = "";
    }
    safeEmit(state.copyWith(emailError: emailError));
  }

  void validatePassword() {
    final String passwordError;
    if (passwordFieldController.text.isEmpty) {
      passwordError = "Enter a password";
    } else if (passwordFieldController.text.length < 6) {
      passwordError = "Password is too short (min 6 characters)";
    } else {
      passwordError = "";
    }
    safeEmit(state.copyWith(passwordError: passwordError));
  }

  void validateRepeatPassword() {
    final String repeatPasswordError;
    if (repeatPasswordFieldController.text.isEmpty) {
      repeatPasswordError = "Repeat your password";
    } else if (repeatPasswordFieldController.text != passwordFieldController.text) {
      repeatPasswordError = "Passwords do not match";
    } else {
      repeatPasswordError = "";
    }
    safeEmit(state.copyWith(repeatPasswordError: repeatPasswordError));
  }

  @override
  Future<void> close() {
    emailFieldController.dispose();
    passwordFieldController.dispose();
    repeatPasswordFieldController.dispose();
    return super.close();
  }
}
