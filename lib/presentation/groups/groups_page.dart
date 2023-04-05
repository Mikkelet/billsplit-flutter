import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/main.dart';
import 'package:billsplit_flutter/presentation/group/group_page.dart';
import 'package:billsplit_flutter/presentation/groups/bloc/groups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groups = [0, 1, 2, 3, 4, 5].map((e) => Group.mock(e));
    return Scaffold(
      body: BlocProvider(
        create: (context) => GroupsBloc()..loadGroups(),
        child: BlocBuilder<GroupsBloc, GroupsState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                ...groups.map(
                  (group) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(GroupPage.route,
                              arguments: {"group_id": group.id});
                        },
                        child: Column(
                          children: [
                            Text(group.name),
                            Text(group.createdBy.name),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
