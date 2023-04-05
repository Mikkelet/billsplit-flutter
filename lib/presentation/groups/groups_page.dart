import 'package:billsplit_flutter/presentation/main_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainNavCubit>();
    if (cubit.state is! ShowGroups) {
      return const Center();
    } else {
      final groups = (cubit.state as ShowGroups).groups;
      return Scaffold(
        body: Column(
          children: [
            ...groups.map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      cubit.showGroup(e);
                    },
                    child: Column(
                      children: [
                        Text(e.name),
                        Text(e.createdBy.name),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
