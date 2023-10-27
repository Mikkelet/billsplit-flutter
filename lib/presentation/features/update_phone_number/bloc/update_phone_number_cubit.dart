import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_state.dart';

class UpdatePhoneNumberCubit extends BaseCubit {

  int currentStep = 1;
  static const int _maxStep = 3;
  String verificationId = "";

  String phoneNumber = "";

  void sendSms(String phoneNumber) {
    emit(Loading());
    this.phoneNumber = phoneNumber;
    authProvider
        .updatePhoneNumber(
      phoneNumber: phoneNumber,
      onCodeSent: (verificationId) {
        this.verificationId = verificationId;
        emit(Main());
        nextStep();
      },
    )
        .catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  void submitCode(String code) {
    emit(Loading());
    authProvider.submitSmsCode(verificationId, code).then((_) {
      user.phoneNumberState = phoneNumber;
      emit(Main());
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
    if (currentStep > 2) {
      currentStep--;
      emit(UpdateStep());
    }
  }
}
