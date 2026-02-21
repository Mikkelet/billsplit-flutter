import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/get_exchange_rates_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/update_display_name_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/bloc/onboarding_state.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_change_display_name.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_default_currency.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_phone_number.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_upload_pfp_screen.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingBloc extends SafeCubit<OnboardingState> {
  final _updateNameUseCase = UpdateDisplayNameUseCase();
  final _getCurrencies = GetExchangeRatesUseCase();
  final _parsePhoneNumberUseCase = ParsePhoneNumberUseCase();
  final SharedPrefs _prefs;
  final AuthRepository _authRepository;

  late final steps = [
    const OnboardingStepWelcomeView(),
    const OnboardingStepChangeDisplayName(),
    const OnboardingStepUploadProfilePicture(),
    const OnboardingStepDefaultCurrency(),
    if (!_user.isGuest) const OnboardingStepPhoneNumber(),
  ];

  final nameController = TextEditingController();
  final pageController = PageController();

  String get _name => nameController.text;

  Person get _user => _authRepository.loggedInUser;

  int get _currentStep => pageController.page?.toInt() ?? 0;

  bool get isLastStep => _currentStep == steps.length - 1;

  OnboardingBloc(this._prefs, this._authRepository) : super(const OnboardingState()) {
    _init();
  }

  Future<void> _init() async {
    try {
      safeEmit(state.loading());
      await Future.wait([
        _initCurrency(),
        _initPhoneNumber(),
      ]);
    } catch (e, st) {
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
      logError(e, st);
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _initPhoneNumber() async {
    await _parsePhoneNumberUseCase.launch(_user.phoneNumber.dial);
  }

  Future<void> _initCurrency() async {
    await _getCurrencies.launch();
    final currencyRate = _prefs.getExchangeRate(_prefs.userPrefDefaultCurrency);
    if (currencyRate != null) {
      safeEmit(
        state.copyWith(
          selectedCurrency: Currency(
            symbol: _prefs.userPrefDefaultCurrency,
            rate: currencyRate,
          ),
        ),
      );
    }
  }

  Future<void> updateName(String name) async {
    try {
      safeEmit(state.loading());
      await _updateNameUseCase.launch(name);
      // TODO: _user.name = name;
    } catch (e, st) {
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
      logError(e, st);
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  Future<void> submitProfile() async {
    try {
      safeEmit(state.loading());
      await _updateNameUseCase.launch(nameController.text);
    } catch (e, st) {
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
      logError(e, st);
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void updateCurrency(Currency currency) {
    _prefs.userPrefDefaultCurrency = currency.symbol;
  }

  void onNextClicked() {
    pageController.nextPage(
      curve: Curves.fastEaseInToSlowEaseOut,
      duration: 500.ms,
    );
  }

  void onPreviousClicked() {
    pageController.previousPage(
      curve: Curves.fastEaseInToSlowEaseOut,
      duration: 500.ms,
    );
  }

  String nextButtonText(StatelessWidget widget) {
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
    pageController.dispose();
    return super.close();
  }
}
