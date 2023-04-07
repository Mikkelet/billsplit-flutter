import 'package:billsplit_flutter/domain/use_cases/initialize_auth_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class SplashCubit extends BaseCubit {
  final _initializeAuthUseCase = InitializeAuthUseCase();

  void initializeAuth() async {
    _initializeAuthUseCase.initialize().then((value) {
      emit(Main());
    }).catchError((onError) {
      showError(onError);
    });
  }
}
