import 'package:billsplit_flutter/domain/use_cases/sign_up_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';

class SignUpCubit extends BaseCubit {
  final _signUpUseCase = SignUpUseCase();

  void signUp(String email, String password) async {
    showLoading();
    _signUpUseCase.launch(email, password).then((data) {
      emit(SignUpSuccessful());
    }).catchError((err, st) {
      showError(err, st);
      emit(Main());
    });
  }
}
