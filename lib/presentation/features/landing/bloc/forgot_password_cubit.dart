import 'package:billsplit_flutter/domain/use_cases/profile/forgot_password_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';

class ForgotPasswordCubit extends BaseCubit {
  final _forgotPasswordUseCase = ForgotPasswordUseCase();

  void forgotPassword(String email) {
    showLoading();
    _forgotPasswordUseCase.launch(email).then((value) {
      emit(ResetPasswordSent());
    }).catchError((err, st) {
      showError(err, st);
    });
  }
}
