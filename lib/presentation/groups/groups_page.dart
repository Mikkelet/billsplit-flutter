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
      body: BlocProvider(
        create: (context) => GroupsBloc()..loadGroups(),
        child: BlocBuilder<GroupsBloc, GroupsState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
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
            if(state is FailureState){
              return Center(
                child: Text(state.exception.toString()),
              );
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
