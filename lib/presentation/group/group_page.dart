import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:billsplit_flutter/presentation/group/widgets/debts_view.dart';
import 'package:billsplit_flutter/presentation/group/widgets/events_view.dart';
import 'package:billsplit_flutter/presentation/group/widgets/group_bottom_nav.dart';
import 'package:billsplit_flutter/presentation/group/widgets/services_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupPage extends StatelessWidget {
  final Group group;

  const GroupPage({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupBloc(group)..loadGroup(),
      child: BlocBuilder<GroupBloc, UiState>(builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                _onFabClicked(context);
              }),
          appBar: AppBar(
              title: Text(group.name),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    _onBackButtonPressed(state, context);
                  })),
          bottomNavigationBar: const GroupBottomNav(),
          body: Builder(builder: (context) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is Failure) {
              return Center(child: Text(state.error.toString()));
            }
            if (state is GroupLoaded) {
              return WillPopScope(child: Builder(builder: (context) {
                switch (state.nav) {
                  case GroupPageNav.services:
                    return const ServicesView();
                  case GroupPageNav.debt:
                    return const DebtsView();
                  default:
                    return const EventsView();
                }
              }), onWillPop: () async {
                if (state.nav != GroupPageNav.events) {
                  context.read<GroupBloc>().showEvents();
                  return false;
                }
                return true;
              });
            }
            return Container();
          }),
        );
      }),
    );
  }

  _onFabClicked(BuildContext context) {
    Navigator.of(context).push(AddExpensePage.getRoute(group, null));
  }

  _onBackButtonPressed(UiState state, BuildContext context) {
    if (state is GroupLoaded && state.nav != GroupPageNav.events) {
      context.read<GroupBloc>().showEvents();
    } else {
      Navigator.of(context).pop();
    }
  }

  static Route getRoute(Group group) => MaterialPageRoute(
      builder: (context) => GroupPage(group: group),
      settings: RouteSettings(arguments: {"group_id": group.id}));
}
