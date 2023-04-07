import 'package:billsplit_flutter/domain/use_cases/sign_in_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/landing/bloc/landing_state.dart';
import 'package:billsplit_flutter/presentation/utils/response.dart';

class LandingBloc extends BaseCubit {
  final _signInUseCase = SignInUseCase();
  LandingPageNav _nav = LandingPageNav.signIn;

  void signIn(String email, String password) async {
    showLoading();
    final response = await _signInUseCase.launch(email, password).execute();
    response.foldResponse(onSuccess: (data) {
      showLanding();
    }, onFailure: (err) {
      print(err);
      showLanding();
    });
  }

  void showLanding() {
    emit(ShowLanding(_nav));
  }

  void showSignIn() {
    _nav = LandingPageNav.signIn;
    showLanding();
  }

  void showSignUp() {
    _nav = LandingPageNav.signUp;
    showLanding();
  }
}
