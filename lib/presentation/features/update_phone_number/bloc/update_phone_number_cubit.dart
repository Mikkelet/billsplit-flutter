import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_state.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:country_code_picker/country_code_picker.dart';

class UpdatePhoneNumberCubit extends BaseCubit {
  int _currentStep = 0;
  static const int _maxStep = 1;
  String verificationId = "";
  String selectedCountry = "+45";
  String phoneNumber = "";

  UpdatePhoneNumberCubit(PhoneNumber? phoneNumber) {
    if (phoneNumber != null) {
      this.phoneNumber = phoneNumber.phoneNumber;
      selectedCountry = phoneNumber.countryCode;
    }
  }

  void sendSms(String phoneNumber) {
    emit(Loading());
    this.phoneNumber = "$selectedCountry$phoneNumber";
    authProvider
        .updatePhoneNumber(
      phoneNumber: this.phoneNumber,
      onCodeSent: _onCodeSent,
      onFailed: _onFailed,
    )
        .catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  void _onFailed(UiException e) {
    showError(e, null);
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
    if (_currentStep < _maxStep) {
      _currentStep++;
      emit(UpdateStep(step: _currentStep));
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      emit(UpdateStep(step: _currentStep));
    }
  }

  void changeCountryCode(CountryCode country) {
    if (country.code == null) {
      emit(Failure(UiException(400, "unexpected error occurred")));
    } else {
      selectedCountry = country.code!;
      emit(Main());
    }
  }

  bool isPhoneNumberChanged(String input) {
    return input != phoneNumber;
  }
}
