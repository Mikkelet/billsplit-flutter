import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
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
import 'package:billsplit_flutter/presentation/features/group_settings/group_settings_page.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/services_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupPage extends StatelessWidget {
  final Group group;

  const GroupPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<GroupBloc>(
      create: (context) => GroupBloc(group)..loadGroup(),
      child: BaseBlocBuilder<GroupBloc>(
        builder: (cubit, state) {
          return BaseScaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Builder(
              builder: (context) {
                if (state is GroupState) {
                  if (state.nav == GroupPageNav.debt) return const SizedBox();
                  final text = state.nav == GroupPageNav.events
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
                foregroundColor:
                    group.coverImageUrlState.isEmpty ? null : Colors.white,
                title: Text(group.nameState),
                systemOverlayStyle: group.coverImageUrlState.isEmpty
                    ? null
                    : const SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.light,
                        statusBarBrightness: Brightness.light,
                      ),
                flexibleSpace: Builder(builder: (context) {
                  if (group.coverImageUrlState.isEmpty)
                    return Container(
                      color: Theme.of(context).colorScheme.tertiary,
                    );
                  return Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: group.coverImageUrlState,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.black38,
                      )
                    ],
                  );
                }),
                surfaceTintColor: Theme.of(context).colorScheme.surface,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(GroupSettings.getRoute(group));
                      },
                      icon: const Icon(Icons.settings))
                ],
                leading: const BackButton()),
            bottomNavigationBar: const GroupBottomNav(),
            body: Builder(
              builder: (context) {
                if (state is Loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: WillPopScope(
                    child: Stack(
                      children: [
                        Builder(builder: (context) {
                          switch (cubit.navIndex) {
                            case GroupPageNav.services:
                              return const ServicesView();
                            case GroupPageNav.debt:
                              return const DebtsView();
                            default:
                              return const EventsView();
                          }
                        }),
                        if (cubit.state is SyncingGroup)
                          const Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator()),
                              ))
                      ],
                    ),
                    onWillPop: () async {
                      return _tryPop(cubit);
                    },
                  ),
                );
              },
            ),
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
