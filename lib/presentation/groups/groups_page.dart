import 'package:billsplit_flutter/presentation/add_group/add_group_page.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/groups/bloc/groups_bloc.dart';
import 'package:billsplit_flutter/presentation/groups/bloc/groups_state.dart';
import 'package:billsplit_flutter/presentation/groups/widgets/group_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is Failure) {
              return Center(child: Text(state.error.toString()));
            }
            if (state is GroupsLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: 80),
                    ...state.groups.map(
                      (group) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GroupView(group: group),
                      ),
                    )
                  ],
                ),
              );
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
