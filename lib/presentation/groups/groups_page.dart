import 'package:billsplit_flutter/presentation/add_group/add_group_page.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/common/extended_fab.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/groups/bloc/groups_bloc.dart';
import 'package:billsplit_flutter/presentation/groups/widgets/group_view.dart';
import 'package:billsplit_flutter/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatelessWidget {
  GroupsPage({Key? key}) : super(key: key);

  final scrollingController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => GroupsBloc()..loadGroups(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Splitsby"),
          actions: [
            Builder(builder: (context) {
              final cubit = context.read<GroupsBloc>();
              return InkWell(
                  onTap: () {
                    Navigator.of(context).push(ProfilePage.getRoute());
                  },
                  child: ProfilePictureView(person: cubit.user));
            }),
            const SizedBox(width: 16)
          ],
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
        body: BaseBlocBuilder<GroupsBloc>(
          builder: (cubit, state) {
            return Center(
              child: RefreshIndicator(
                onRefresh: () async {
                  await cubit.refreshGroups();
                },
                child: DefaultStreamBuilder(
                  stream: cubit.getGroupStream(),
                  body: (groups) {
                    if (state is Loading && groups.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (groups.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(64.0),
                          child: Text(
                            "Here you can see your groups! Click below to add one!",
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                        controller: scrollingController,
                        itemCount: groups.length,
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GroupView(group: groups[index]),
                            ));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
