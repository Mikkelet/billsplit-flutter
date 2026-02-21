import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/features/splash/bloc/splash_state.dart';

class SplashCubit extends SafeCubit<SplashState> {
  SplashCubit() : super(const SplashState());
}
