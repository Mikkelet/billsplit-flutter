import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';

class LandingBloc extends BaseCubit {
  void showSignUp() {
    emit(ShowSignUp());
  }

  void showSignIn() {
    emit(Main());
  }
}
