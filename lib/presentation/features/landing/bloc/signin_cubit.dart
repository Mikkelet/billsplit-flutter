import 'package:billsplit_flutter/domain/use_cases/sign_in_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/susi/sign_in_with_google_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class SignInCubit extends BaseCubit {
  final _signInUseCase = SignInWithEmailUseCase();
  final _signInWithGoogleUseCase = SignInWithGoogleUseCase();

  void signIn(String email, String password) async {
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
    _signInWithGoogleUseCase.launch().then((value) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }
}
