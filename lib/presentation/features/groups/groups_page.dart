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
            appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 64),
              child: Builder(
                builder: (context) {
                  // Needs to wrapped in Builder to get appdrawer to work
                  return _appBar(context);
                }
              ),
            ),
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cubit.getGreeting(), style: Theme.of(context).textTheme.displayLarge),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              controller: scrollingController,
                              itemCount: groups.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: GroupView(group: groups[index]),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      actions: [Container()],
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 64),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(Icons.menu))
            ],
          ),
        ),
      ),
    );
  }
}
