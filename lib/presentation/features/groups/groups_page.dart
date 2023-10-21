import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
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

  final _scrollingController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => GroupsBloc()..loadProfile(),
      child: BlocBuilder<GroupsBloc, UiState>(
        builder: (context, state) {
          final cubit = context.read<GroupsBloc>();
          return BaseScaffold(
            endDrawer: const Drawer(
              child: ProfilePage(),
            ),
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
                      controller: _scrollingController,
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: 200.0,
                          forceMaterialTransparency: true,
                          flexibleSpace: FlexibleSpaceBar(
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
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: groups.length,
                            (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8),
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

class FadeContainer extends StatefulWidget {
  @protected
  final ScrollController scrollController;

  const FadeContainer({super.key, required this.scrollController});

  @override
  State<FadeContainer> createState() => _FadeAppBarState();
}

class _FadeAppBarState extends State<FadeContainer> {
  double _opacity = 0.0;

  _scrollListen() {
    final offset = widget.scrollController.offset;
    if (offset > 200) {
      if (_opacity != 1.0) {
        setState(() {
          _opacity = 1.0;
        });
      }
    } else if (offset < 10) {
      if (_opacity != 0.0) {
        setState(() {
          _opacity = 0.0;
        });
      }
    } else {
      setState(() {
        _opacity = offset / 200;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListen);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: Container(
        decoration: const BoxDecoration(color: Colors.red),
      ),
    );
  }
}
