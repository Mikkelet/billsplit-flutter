import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/add_group_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';

class DefaultGroupCurrencyCubit extends BaseCubit {
  final Group group;
  final _addGroupUseCase = AddGroupUseCase();

  DefaultGroupCurrencyCubit(this.group);

  void updateCurrency(Currency currency) {
    final cached = currency;
    group.defaultCurrencyState.value = currency.symbol;
    showLoading();
    _addGroupUseCase.launch(group).then((value) {
    }).catchError((err, st) {
      group.defaultCurrencyState.value = cached.symbol;
      showError(err, st);
    });
  }
}
