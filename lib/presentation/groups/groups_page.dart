import 'package:billsplit_flutter/presentation/add_group/add_group_page.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/friends/friends_page.dart';
import 'package:billsplit_flutter/presentation/groups/bloc/groups_bloc.dart';
import 'package:billsplit_flutter/presentation/groups/widgets/group_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(FriendsPage.getRoute());
              },
              icon: const Icon(Icons.people))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(AddGroupPage.getRoute());
        },
      ),
      body: BlocProvider(
        create: (context) => GroupsBloc()..loadGroups(),
        child: BlocBuilder<GroupsBloc, BaseState>(
          builder: (context, state) {
            final cubit = context.read<GroupsBloc>();
            return Center(
              child: DefaultStreamBuilder(
                stream: cubit.getGroupStream(),
                noData: const Text("No groups"),
                listItem: (e) => GroupView(group: e),
              ),
            );
          },
        ),
      ),
    );
  }
}
