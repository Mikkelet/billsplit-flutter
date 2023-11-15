import 'dart:io';

import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/features/add_group/add_group_page.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/extended_fab.dart';
import 'package:billsplit_flutter/presentation/features/groups/bloc/groups_bloc.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/drawer_action_view.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/group_view.dart';
import 'package:billsplit_flutter/presentation/features/profile/profile_page.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  GroupsPage({super.key});

  final _scrollingController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => GroupsBloc()..loadProfile(),
      child: BaseBlocBuilder<GroupsBloc>(
        builder: (cubit, state) {
          return BaseScaffold(
            endDrawer: const Drawer(child: ProfilePage()),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: ExtendedFloatingActionButton(
              scrollController: _scrollingController,
              label: "Add group",
              icon: Icons.group_add_rounded,
              onPressed: () {
                Navigator.of(context).push(AddGroupPage.getRoute());
              },
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await cubit.loadProfile();
              },
              child: Center(
                child: StreamBuilder<List<Group>>(
                  stream: cubit.getGroupStream(),
                  initialData: const [],
                  builder: (_, snapshot) {
                    final groups = snapshot.data!;
                    return CustomScrollView(
                      controller: _scrollingController,
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          actions: const [DrawerActionView()],
                          expandedHeight: 200.0,
                          forceMaterialTransparency: true,
                          flexibleSpace: FlexibleSpaceBar(
                            titlePadding:
                                Platform.isIOS ? const EdgeInsets.all(8) : null,
                            background: Container(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    cubit.getGreeting(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverLayoutBuilder(builder: (context, _) {
                          if (state is Loading && groups.isEmpty) {
                            return SliverFillViewport(
                              viewportFraction: 0.5,
                              delegate: SliverChildListDelegate([
                                const Center(child: CircularProgressIndicator())
                              ]),
                            );
                          }
                          if (groups.isEmpty) {
                            return SliverFillViewport(
                              delegate: SliverChildListDelegate([
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(64.0),
                                    child: Text(
                                      "Here you can see your groups! Click below to add one!",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ),
                                ),
                              ]),
                            );
                          }
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: groups.length,
                              (context, index) {
                                final group = groups[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 8),
                                  child: GroupView(
                                    group: group,
                                    debtToGroup: cubit.getDebtForGroup(group),
                                  ),
                                );
                              },
                            ),
                          );
                        })
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
