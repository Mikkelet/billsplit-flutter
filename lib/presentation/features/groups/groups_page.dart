import 'package:billsplit_flutter/presentation/features/add_group/add_group_page.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/common/extended_fab.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/groups/bloc/groups_bloc.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/group_view.dart';
import 'package:billsplit_flutter/presentation/features/profile/profile_page.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
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
            appBar: _appBar(context),
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
            body: Center(
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
                    return ListView.builder(
                      controller: scrollingController,
                      itemCount: groups.length,
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 16),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GroupView(group: groups[index]),
                        );
                      },
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
    final cubit = context.read<GroupsBloc>();
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Splitsby",
                  style: SplitsbyTextTheme.splitsbyTitle(context)),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(ProfilePage.getRoute());
                },
                child: ProfilePictureView(person: cubit.user, size: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
