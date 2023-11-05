import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/features/group_invites/bloc/group_invite_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group_invites/widgets/group_invite_view.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class GroupInvitesPage extends StatelessWidget {
  const GroupInvitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<GroupInvitesCubit>(
      create: (context) => GroupInvitesCubit(),
      child: BaseBlocBuilder<GroupInvitesCubit>(
        builder: (cubit, state) {
          return BaseScaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text("Group invites"),
            ),
            body: DefaultStreamBuilder(
              stream: cubit.groupsStream(),
              builder: (context, snapshot) {
                final groups = snapshot.toList();
                if (groups.isEmpty) {
                  return const Center(child: Text("You do not have any new invites"));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: snapshot.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: GroupInviteView(groupInvite: group),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  static Route get route => slideLeftRoute(const GroupInvitesPage());
}
