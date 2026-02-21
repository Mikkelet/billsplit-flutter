import 'package:billsplit_flutter/domain/use_cases/profile/confirm_phone_number_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/update_phone_number_use_case.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_state.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class UpdatePhoneNumberCubit extends SafeCubit<UpdatePhoneNumberState> {
  final _updatePhoneNumberUseCase = UpdatePhoneNumberUseCase();
  final _confirmPhoneNumberUseCase = ConfirmPhoneNumberUseCase();
  final _parsePhoneNumber = ParsePhoneNumberUseCase();

  int _currentStep = 0;
  final String? _initialPhoneNumber;
  static const int _maxStep = 1;
  final PageController pageController = PageController();
  final TextEditingController textEditingController = TextEditingController();

  UpdatePhoneNumberCubit(this._initialPhoneNumber) : super(const UpdatePhoneNumberState());

  void init() async {
    try {
      safeEmit(state.loading());
      final parsed = await _parsePhoneNumber.launch(_initialPhoneNumber);
      if (parsed != null) {
        safeEmit(state.copyWith(phoneNumber: parsed.phoneNumber, countryCode: parsed.countryCode));
      }
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(errorMessage: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void sendSms(String phoneNumber) async {
    try {
      safeEmit(state.loading());
      final fullNumber = "${state.countryCode}${state.phoneNumber}";
      await _updatePhoneNumberUseCase.launch(
        phoneNumber: fullNumber,
        onCodeSent: _onCodeSent,
        onFailed: _onFailed,
      );
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(errorMessage: SplitsbyError.unknown(e.toString())));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onFailed(UiException e) {
    logError(e, StackTrace.current);
    safeEmit(state.copyWith(errorMessage: SplitsbyError.unknown(e.toString())));
  }

  void _onCodeSent(String verificationId) {
    nextStep();
  }

  void submitCode() async {
    try {
      safeEmit(state.loading());
      await _confirmPhoneNumberUseCase.launch(
        textEditingController.text,
        textEditingController.text,
      );
    } catch (e, st) {
      logError(e, st);
      safeEmit(
        state.copyWith(errorMessage: SplitsbyError.unknown(e.toString())),
      );
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
      emit(state.copyWith(errorMessage: SplitsbyError.unknown("")));
    } else {
      emit(state.copyWith(countryCode: country.dialCode!));
    }
  }

  bool isPhoneNumberChanged(String input) {
    return input != state.phoneNumber;
  }

  void updateStep() {
    pageController.animateToPage(
      _currentStep,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
