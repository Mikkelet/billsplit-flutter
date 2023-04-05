import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/models/group.dart';

class MainNavState {}

class ShowLoading extends MainNavState {}

class ShowGroups extends MainNavState {
  final List<Group> groups;

  ShowGroups(this.groups);
}

class ShowGroup extends MainNavState {
  final Group group;

  ShowGroup(this.group);
}

class ShowAddExpense extends MainNavState {
  final GroupExpense groupExpense;

  ShowAddExpense(this.groupExpense);

  ShowAddExpense.newExpense() : this(GroupExpense.dummy(0));
}

class MainNavCubit extends Cubit<MainNavState> {
  MainNavCubit() : super(ShowLoading());

  void showGroups() async {
    emit(ShowLoading());
    await Future.delayed(const Duration(seconds: 2));
    emit(ShowGroups([0, 1, 2, 3, 4, 5].map((e) => Group.mock(e)).toList()));
  }

  void showGroup(Group group) {
    emit(ShowGroup(group));
  }
}
