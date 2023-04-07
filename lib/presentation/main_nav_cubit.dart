import 'package:billsplit_flutter/domain/use_cases/observe_auth_state_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/domain/use_cases/initialize_auth_usecase.dart';

import 'base/bloc/base_state.dart';

class MainCubit extends BaseCubit {
  final _observeAuthStateUseCase = ObserveAuthStateUseCase();
  final _initializeAuthUseCase = InitializeAuthUseCase();

  MainCubit() : super.withState(Loading());

  Stream<String?> observeAuthState() {
    return _observeAuthStateUseCase.observe();
  }

  void initialize() {
    showLoading();
    _initializeAuthUseCase.initialize().then((value) {
      showGroups();
    }).catchError((err) {
      showError(err);
    });
  }

  void showGroups() async {
    emit(Main());
  }
}
