import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/use_cases/update_display_name_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class UpdateCurrencyCubit extends BaseCubit {
  final _updateNameUseCase = UpdateDisplayNameUseCase();

  Future updateName(String name) async {
    await _updateNameUseCase.launch(name);
    user.nameState = name;
  }

  void updateCurrency(Currency currency) {
    sharedPrefs.userPrefDefaultCurrency = currency.symbol;
    emit(Main());
  }
}