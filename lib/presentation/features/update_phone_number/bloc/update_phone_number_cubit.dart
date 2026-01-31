import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/confirm_phone_number_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/update_phone_number_use_case.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_state.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePhoneNumberCubit extends Cubit<UpdatePhoneNumberState> {
  final _updatePhoneNumberUseCase = UpdatePhoneNumberUseCase();
  final _confirmPhoneNumberUseCase = ConfirmPhoneNumberUseCase();

  int _currentStep = 0;
  static const int _maxStep = 1;
  final PageController pageController = PageController();
  String _verificationId = "";

  UpdatePhoneNumberCubit(PhoneNumber? phoneNumber)
      : super(UpdatePhoneNumberState(
          countryCode: phoneNumber?.countryCode ?? "",
          phoneNumber: phoneNumber?.phoneNumber ?? "",
        ));

  void sendSms(String phoneNumber) async {
    try {
      emit(state.copyWith(isLoading: true));
      final fullNumber = "${state.countryCode}${state.phoneNumber}";
      await _updatePhoneNumberUseCase.launch(
        phoneNumber: fullNumber,
        onCodeSent: _onCodeSent,
        onFailed: _onFailed,
      );
    } catch (e, st) {
      // showError(err, stackTrace);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onFailed(UiException e) {
    // showError(e, null);
  }

  void _onCodeSent(String verificationId) {
    _verificationId = verificationId;
    nextStep();
  }

  void submitCode(String code) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _confirmPhoneNumberUseCase.launch(_verificationId, code);
      // emit success
      //emit(UpdateNumberSuccess());
    } catch (e, st) {
      // showError(e, st);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void nextStep() {
    if (_currentStep < _maxStep) {
      _currentStep++;
    }
    updateStep();
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
    }
    updateStep();
  }

  void changeCountryCode(CountryCode country) {
    if (country.dialCode == null) {
      emit(state.copyWith(errorMessage: "Unexpected error occurred"));
    } else {
      emit(state.copyWith(countryCode: country.dialCode!));
    }
  }

  bool isPhoneNumberChanged(String input) {
    return input != state.phoneNumber;
  }

  void updateStep() {
    pageController.animateToPage(_currentStep,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
