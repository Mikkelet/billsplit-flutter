import 'package:billsplit_flutter/domain/use_cases/sign_in_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/sign_up_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';

class LandingBloc extends BaseCubit {
  final _signInUseCase = SignInUseCase();
  final _signUpUseCase = SignUpUseCase();

  void signIn(String email, String password) async {
    showLoading();
    _signInUseCase.launch(email, password).then((data) {
      showLanding();
    }).catchError((err) {
      showError(err);
      showLanding();
    });
  }

  void signUp(String email, String password) async {
    showLoading();
    _signUpUseCase.launch(email, password).then((data) {
      showLanding();
    }).catchError((err) {
      showError(err);
      showLanding();
    });
  }

  void showLanding() {
    emit(Main());
  }

  void showSignIn() {
    emit(Main());
  }

  void showSignUp() {
    emit(ShowSignUp());
  }
}
