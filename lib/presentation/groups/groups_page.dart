import 'package:billsplit_flutter/presentation/add_group/add_group_page.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/groups/bloc/groups_bloc.dart';
import 'package:billsplit_flutter/presentation/groups/widgets/group_view.dart';
import 'package:billsplit_flutter/presentation/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => GroupsBloc()..loadGroups(),
      child: Scaffold(
        appBar: AppBar(
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(AddGroupPage.getRoute());
          },
        ),
        body: BaseBlocBuilder<GroupsBloc>(
          builder: (cubit, state) {
            return Center(
              child: DefaultStreamBuilder(
                stream: cubit.getGroupStream(),
                body: (groups) {
                  if (state is Loading && groups.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (groups.isEmpty) {
                    return const Center(child: Text("no groups"));
                  }
                  return ListView.builder(
                      itemCount: groups.length,
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GroupView(group: groups.toList()[index]),
                          ));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
