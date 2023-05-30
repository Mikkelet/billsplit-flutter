import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/common/extended_fab.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/features/add_service/add_service_page.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/debts_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/events_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/group_bottom_nav.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/group_settings.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/services_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupPage extends StatelessWidget {
  final Group group;

  const GroupPage({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<GroupBloc>(
      listener: (context, cubit, state) {
        if (state is GroupLeft) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      create: (context) => GroupBloc(group)..loadGroup(),
      child: BaseBlocBuilder<GroupBloc>(
        builder: (cubit, state) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Builder(
              builder: (context) {
                if (state is GroupState) {
                  if (state.nav == GroupPageNav.debt) return const SizedBox();
                  if (state.nav == GroupPageNav.settings) return const SizedBox();
                  String text = state.nav == GroupPageNav.events
                      ? "Add expense"
                      : "Add subscription";
                  return ExtendedFloatingActionButton(
                    scrollController: ScrollController(),
                    onPressed: () {
                      _onFabClicked(context);
                    },
                    label: text,
                    icon: Icons.add,
                  );
                }
                return const SizedBox();
              },
            ),
            appBar: AppBar(
                elevation: 0,
                title: Text(group.nameState),
                surfaceTintColor: Theme.of(context).colorScheme.surface,
                actions: [
                  IconButton(
                      onPressed: () {
                        cubit.showSettings();
                      },
                      icon: const Icon(Icons.settings))
                ],
                leading: const BackButton()),
            bottomNavigationBar: const GroupBottomNav(),
            body: Builder(builder: (context) {
              if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: WillPopScope(
                  child: Builder(builder: (context) {
                    switch (cubit.navIndex) {
                      case GroupPageNav.services:
                        return const ServicesView();
                      case GroupPageNav.debt:
                        return const DebtsView();
                      case GroupPageNav.settings:
                        return const GroupSettings();
                      default:
                        return const EventsView();
                    }
                  }),
                  onWillPop: () async {
                    return _tryPop(cubit);
                  },
                ),
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

  bool _tryPop(GroupBloc cubit) {
    if (cubit.navIndex != GroupPageNav.events) {
      cubit.showEvents();
      return false;
    }
    return true;
  }

  static Route getRoute(Group group) => MaterialPageRoute(
      builder: (context) => GroupPage(group: group),
      settings: RouteSettings(arguments: {"group_id": group.id}));
}
