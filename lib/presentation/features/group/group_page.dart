import 'package:billsplit_flutter/presentation/common/extended_fab.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/features/add_service/add_service_route.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/debts_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/events_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/group_bottom_nav.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/services_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/sort_button.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/group_settings_route.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/presentation/utils/bloc_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context)?.settings.arguments;
    final cubit = context.read<GroupBloc>();
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Builder(
            builder: (context) {
              if (state.isLoading) {
                return const SizedBox();
              }
              if (state.groupNav == GroupPageNav.debt) {
                return const SizedBox();
              }
              final text = state.groupNav == GroupPageNav.events
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
            },
          ),
          appBar: state.isLoading
              ? null
              : AppBar(
                  elevation: 0,
                  foregroundColor: state.requireGroup.coverImageUrlState.value.isEmpty
                      ? null
                      : Colors.white,
                  title: MutableValue(
                    mutableValue: state.requireGroup.nameState,
                    builder: (context, value) => Text(value),
                  ),
                  systemOverlayStyle: state.requireGroup.coverImageUrlState.value.isEmpty
                      ? null
                      : const SystemUiOverlayStyle(
                          statusBarIconBrightness: Brightness.light,
                          statusBarBrightness: Brightness.light,
                        ),
                  flexibleSpace: Builder(
                    builder: (context) {
                      if (state.requireGroup.coverImageUrlState.value.isEmpty) {
                        return Container(
                          color: Theme.of(context).colorScheme.tertiary,
                        );
                      }
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: state.requireGroup.coverImageUrlState.value,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            color: Colors.black38,
                          ),
                        ],
                      );
                    },
                  ),
                  surfaceTintColor: Theme.of(context).colorScheme.surface,
                  actions: [
                    const SortActionButton(),
                    IconButton(
                      onPressed: () async {
                        GroupSettingsRoute(state.requireGroup).push(context);
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                  leading: const BackButton(),
                ),
          bottomNavigationBar: const GroupBottomNav(),
          body: Builder(
            builder: (context) {
              if (state.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: PopScope(
                  canPop: cubit.state.groupNav == GroupPageNav.events,
                  onPopInvokedWithResult: (didPop, result) {
                    cubit.showEvents();
                  },
                  child: Stack(
                    children: [
                      Builder(
                        builder: (context) {
                          switch (state.groupNav) {
                            case GroupPageNav.services:
                              return const ServicesView();
                            case GroupPageNav.debt:
                              return const DebtsView();
                            default:
                              return const EventsView();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _onFabClicked(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    final state = cubit.state;
    if (state.groupNav == GroupPageNav.events) {
      Navigator.of(context).push(AddExpensePage.getRoute(context.user, state.requireGroup, null));
    } else {
      if (state.groupNav == GroupPageNav.services) {
        Navigator.of(context).push(addServiceRoute(context.user, state.requireGroup, null));
      }
    }
  }
}
