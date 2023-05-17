import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/add_group_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class DefaultGroupCurrencyCubit extends BaseCubit {
  final Group group;
  final _addGroupUseCase = AddGroupUseCase();

  DefaultGroupCurrencyCubit(this.group);

  void updateCurrency(Currency currency) {
    group.defaultCurrencyState = currency.symbol;
    showLoading();
    _addGroupUseCase.launch(group).then((value) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }
}
