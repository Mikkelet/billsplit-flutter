import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/get_group_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';

class GroupBloc extends BaseCubit {
  final getGroupUseCase = GetGroupUseCase();
  final Group group;
  late final List<Event> _events;
  late final List<SubscriptionService> _services;
  GroupPageNav _navIndex = GroupPageNav.events;

  GroupBloc(this.group) : super.withState(Loading());

  void loadGroup() async {
    showLoading();
    getGroupUseCase.launch(group.id).then((value) {
      _services = value["services"];
      _events = value["events"];
      showPage(_navIndex);
    }).catchError((err) {
      showError(err);
    });
  }

  void showEvents() => showPage(GroupPageNav.events);

  void showServices() => showPage(GroupPageNav.services);

  void showDebt() => showPage(GroupPageNav.events);

  void showPage(GroupPageNav nav) {
    _navIndex = nav;
    final newState = GroupLoaded(group, _events, _navIndex, _services);
    emit(newState);
  }
}
