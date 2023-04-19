import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/add_service/add_service_page.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
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
    return BaseBlocWidget<GroupBloc>(
      create: (context) => GroupBloc(group)..loadGroup(),
      child: BaseBlocBuilder<GroupBloc>(
        builder: (cubit, state) {
          return Scaffold(
            floatingActionButton: Builder(
              builder: (context) {
                if (state is GroupState) {
                  if (state.nav == GroupPageNav.debt) return const SizedBox();
                  String text = state.nav == GroupPageNav.events
                      ? "Add event"
                      : "Add service";
                  return FloatingActionButton.extended(
                      isExtended: true,
                      onPressed: () {
                        _onFabClicked(context);
                      },
                      label: Text(text),
                      icon: const Icon(Icons.add));
                }
                return const SizedBox();
              },
            ),
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: WillPopScope(child: Builder(builder: (context) {
                  switch (cubit.navIndex) {
                    case GroupPageNav.services:
                      return const ServicesView();
                    case GroupPageNav.debt:
                      return const DebtsView();
                    default:
                      return const EventsView();
                  }
                }), onWillPop: () async {
                  if (cubit.navIndex != GroupPageNav.events) {
                    context.read<GroupBloc>().showEvents();
                    return false;
                  }
                  return true;
                }),
              );
            }),
          );
        },
      ),
    );
  }

  _onFabClicked(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    final state = cubit.state;
    if (state is GroupState) {
      if (state.nav == GroupPageNav.events) {
        Navigator.of(context)
            .push(AddExpensePage.getRoute(cubit.user, group, null));
      } else {
        if (state.nav == GroupPageNav.services) {
          Navigator.of(context)
              .push(AddServicePage.getRoute(cubit.user, group, null));
        }
      }
    }
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
