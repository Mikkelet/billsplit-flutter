import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/currency_usecases/convert_currency_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/get_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_groups_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:collection/collection.dart';

class GroupsBloc extends BaseCubit {
  final _getGroupsUseCase = GetGroupsUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();
  final _observeGroupsUseCase = ObserveGroupsUseCase();
  final _convertCurrencyUseCase = ConvertCurrencyUseCase();

  GroupsBloc() : super();

  Stream<List<Group>> getGroupStream() =>
      _observeGroupsUseCase.observe().map((event) => event
          .sortedBy<num>((group) => group.latestEventState?.timestamp ?? 0)
          .reversed
          .toList());

  void loadProfile() async {
    emit(Loading());
    Future.value([_getFriendsUseCase.launch(), _getGroupsUseCase.launch()])
        .then((value) {
      emit(Main());
    }).catchError((error) {
      showError(error);
    });
  }

  Future refreshGroups() async {
    try {
      await _getGroupsUseCase.launch();
    } catch (e) {
      showError(e);
    }
  }

  num convertToDefault(num debt) {
    final userPref = sharedPrefs.userPrefDefaultCurrency;
    return _convertCurrencyUseCase.launch(debt, "usd", userPref);
  }
}
