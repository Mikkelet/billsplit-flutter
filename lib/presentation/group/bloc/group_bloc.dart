import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/get_group_usecase.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:billsplit_flutter/presentation/utils/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupBloc extends Cubit<GroupState> {
  final getGroupUseCase = GetGroupUseCase();
  late final Group _group;
  late final List<Event> _events;
  late final List<SubscriptionService> _services;
  GroupPageNav _navIndex = GroupPageNav.events;

  GroupBloc() : super(Loading());

  void loadGroup(String groupId) async {
    emit(Loading());
    final response = await getGroupUseCase.launch(groupId).execute();
    response.foldResponse(onSuccess: (data) {
      if (data is Map) {
        _group = data["groups"];
        _events = data["events"];
        _services = data["services"];
        emit(GroupLoaded(_group, _events, _navIndex, _services));
      }
    }, onFailure: (err) {
      emit(LoadingFailed());
      print("qqq error=$err");
    });
  }

  void showEvents() => showPage(GroupPageNav.events);

  void showServices() => showPage(GroupPageNav.services);

  void showDebt() => showPage(GroupPageNav.events);

  void showPage(GroupPageNav nav) {
    _navIndex = nav;
    final newState = GroupLoaded(_group, _events, _navIndex, _services);
    emit(newState);
  }
}
