import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_state.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';

class UpdatePhoneNumberCubit extends BaseCubit {
  int currentStep = 1;
  static const int _maxStep = 3;
  String verificationId = "";
  String phoneNumber = "";

  void sendSms(String phoneNumber) {
    emit(Loading());
    this.phoneNumber = phoneNumber;
    authProvider
        .updatePhoneNumber(phoneNumber: phoneNumber, onCodeSent: _onCodeSent)
        .catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  void _onCodeSent(String verificationId) {
    this.verificationId = verificationId;
    nextStep();
  }

  void submitCode(String code) {
    emit(Loading());
    final regex = RegExp("^[0-9]{1,6}\$");
    if (!regex.hasMatch(code)) {
      emit(Failure(UiException(500, "Invalid code")));
      return;
    }
    authProvider.submitSmsCode(verificationId, code).then((_) {
      user.phoneNumberState = phoneNumber;
      emit(UpdateNumberSuccess());
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  void nextStep() {
    if (currentStep < _maxStep) {
      currentStep++;
      emit(UpdateStep());
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      currentStep--;
      emit(UpdateStep());
    }
  }
}
