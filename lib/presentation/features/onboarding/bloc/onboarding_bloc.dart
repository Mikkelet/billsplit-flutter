import 'dart:io';

import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/domain/use_cases/currency_usecases/get_exchange_rates_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/update_display_name_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/bloc/onboarding_state.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_change_display_name.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_default_currency.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_phone_number.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_upload_pfp_screen.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingBloc extends BaseCubit {
  final _updateNameUseCase = UpdateDisplayNameUseCase();
  final _getCurrencies = GetExchangeRatesUseCase();
  final _parsePhoneNumberUseCase = ParsePhoneNumberUseCase();

  final PageController controller;
  int _currentStep = 1;
  late final steps = [
    const OnboardingStepWelcomeView(),
    const OnboardingStepChangeDisplayName(),
    const OnboardingStepUploadProfilePicture(),
    OnboardingStepDefaultCurrency(),
    if (!user.isGuest) const OnboardingStepPhoneNumber(),
  ];

  String _name = "";
  Currency currency = Currency.USD();
  File? displayPhoto;
  PhoneNumber? phoneNumber;

  OnboardingBloc(this.controller) {
    _name = user.nameState;
    _initCurrency();
    _initPhoneNumber();
  }

  _initPhoneNumber() {
    _parsePhoneNumberUseCase.launch(user.phoneNumberState.dial).then((value) {
      phoneNumber = value;
    });
  }

  _initCurrency() {
    _getCurrencies.launch().then((_) {
      final currencyRate =
          sharedPrefs.latestExchangeRates[sharedPrefs.userPrefDefaultCurrency];
      if (currencyRate != null) {
        currency = Currency(
          symbol: sharedPrefs.userPrefDefaultCurrency,
          rate: currencyRate,
        );
      }
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  Future updateName(String name) async {
    await _updateNameUseCase.launch(name);
    user.nameState = name;
  }

  void submitProfile() {
    showLoading();
    _updateNameUseCase.launch(name).then((value) {
      emit(SubmitUserSuccessEvent());
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  void updateCurrency(Currency currency) {
    sharedPrefs.userPrefDefaultCurrency = currency.symbol;
    emit(Main());
  }

  void onNextClicked() {
    if (_currentStep == steps.length) {
      emit(FinishOnboardingEvent());
    } else {
      controller.nextPage(
        duration: 500.ms,
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  void onPreviousClicked() {
    if (_currentStep < 1) {
      emit(FinishOnboardingEvent());
    } else {
      controller.previousPage(
        duration: 500.ms,
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  void onNameChanged(String value) {
    _name = value;
    emit(Main());
  }

  String get name {
    return _name;
  }

  String nextButtonText(Widget widget) {
    final index = steps.indexOf(widget) + 1;
    if (index == 1) {
      return "Let's get started";
    }
    if (index == steps.length) {
      return "I'm ready!";
    }
    return "Next";
  }

  String get greeting {
    if (_name.isEmpty) return "Hi you!";
    return "Hi $_name!";
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }

  void onPageChanged(int page) {
    _currentStep = page + 1;
  }
}
