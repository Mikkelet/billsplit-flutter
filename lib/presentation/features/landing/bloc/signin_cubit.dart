import 'package:billsplit_flutter/domain/use_cases/sign_in_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class SignInCubit extends BaseCubit {
  final _signInUseCase = SignInUseCase();

  void signIn(String email, String password) async {
    showLoading();
    _signInUseCase.launch(email, password).then((data) {
      emit(Main());
    }).catchError((err) {
      showError(err);
      emit(Main());
    });
  }
}
