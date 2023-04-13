import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class AddServiceBloc extends BaseCubit {
  void monthlyExpenseUpdated() {
    emit(Main());
  }

  void submitService() {
    emit(Loading());
  }
}
