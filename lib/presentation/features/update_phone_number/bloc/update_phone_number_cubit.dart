import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_state.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:country_code_picker/country_code_picker.dart';

class UpdatePhoneNumberCubit extends BaseCubit {
  final _parsePhoneNumberUseCase = ParsePhoneNumberUseCase();

  int currentStep = 1;
  static const int _maxStep = 3;
  String verificationId = "";
  String selectedCountry = "+45";
  String phoneNumber = "";

  void init() {
    emit(Loading());
    _parsePhoneNumberUseCase
        .launch(user.phoneNumberState)
        .then((parsedPhoneNumber) {
      if (phoneNumber.isNotEmpty) {
        if (parsedPhoneNumber == null) {
          emit(Failure(UiException(400, "Unexpected error occurred")));
        } else {
          selectedCountry = parsedPhoneNumber.countryCode;
          phoneNumber = parsedPhoneNumber.phoneNumber;
          emit(Main());
        }
      } else {
        emit(Main());
      }
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  void sendSms(String phoneNumber) {
    emit(Loading());
    this.phoneNumber = "+$selectedCountry$phoneNumber";
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
