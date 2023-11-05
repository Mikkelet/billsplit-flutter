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
            appBar: AppBar(backgroundColor: Colors.transparent),
            body: DefaultStreamBuilder(
              stream: cubit.groupsStream(),
              builder: (context, snapshot) {
                final groups = snapshot.toList();
                print("qqq groups=${groups.length}");
                return ListView.builder(
                  itemCount: snapshot.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    return GroupInviteView(groupInvite: group);
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
