import 'package:billsplit_flutter/presentation/features/add_group/add_group_page.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/common/extended_fab.dart';
import 'package:billsplit_flutter/presentation/features/groups/bloc/groups_bloc.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/group_view.dart';
import 'package:billsplit_flutter/presentation/features/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatelessWidget {
  GroupsPage({Key? key}) : super(key: key);

  final scrollingController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => GroupsBloc()..loadProfile(),
      child: BlocBuilder<GroupsBloc, UiState>(
        builder: (context, state) {
          final cubit = context.read<GroupsBloc>();
          return Scaffold(
            endDrawer: const Drawer(
              child: ProfilePage(),
            ),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: ExtendedFloatingActionButton(
                scrollController: scrollingController,
                label: "Add group",
                icon: Icons.group_add_rounded,
                onPressed: () {
                  Navigator.of(context).push(AddGroupPage.getRoute());
                },
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await cubit.refreshGroups();
              },
              child: Center(
                child: DefaultStreamBuilder(
                  stream: cubit.getGroupStream(),
                  builder: (_, groups) {
                    if (state is Loading && groups.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (groups.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(64.0),
                          child: Text(
                            "Here you can see your groups! Click below to add one!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      );
                    }
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          expandedHeight: 200.0,
                          scrolledUnderElevation: 0,
                          stretch: true,
                          flexibleSpace: FlexibleSpaceBar(
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
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: groups.length,
                            (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16),
                                child: GroupView(group: groups[index]),
                              );
                            },
                          ),
                        )
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
