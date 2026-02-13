import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/group_view.dart';
import 'package:billsplit_flutter/presentation/features/inspect_profile/bloc/inspect_profile_cubit.dart';
import 'package:billsplit_flutter/presentation/features/inspect_profile/bloc/inspect_profile_state.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspectProfilePage extends StatelessWidget {
  const InspectProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InspectProfileCubit>();
    final state = cubit.state;
    final person = cubit.person;
    return BlocBuilder<InspectProfileCubit, InspectProfileState>(
      builder: (context, state) {
        return BaseScaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Builder(
            builder: (context) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfilePictureView(person: person, size: 100),
                      const SizedBox(height: 16),
                      Text(
                        person.displayName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 32),
                      if (state.status == FriendStatus.notFriends)
                        TextButton(onPressed: cubit.addFriend, child: const Text("Add friend")),
                      if (state.status == FriendStatus.accepted) const Text("You are friends"),
                      if (state.status == FriendStatus.yourself) const Text("Looking good!"),
                      if (state.status == FriendStatus.requestReceived)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClickableListItem(
                              onClick: () => cubit.respondToFriendRequest(true),
                              color: Theme.of(context).colorScheme.onInverseSurface,
                              width: 100,
                              height: 48,
                              child: const Text("Accept"),
                            ),
                            ClickableListItem(
                              onClick: () => cubit.respondToFriendRequest(false),
                              color: Theme.of(context).colorScheme.error,
                              width: 100,
                              height: 48,
                              child: const Text("Reject"),
                            ),
                          ],
                        ),
                      if (state.status == FriendStatus.requestSent) const Text("Invite sent"),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Groups in common",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (state.groupsInCommon.isNotEmpty)
                        ...state.groupsInCommon.map(
                          (e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GroupView(group: e, debtToGroup: 0, showDebt: false),
                          ),
                        ),
                      if (state.groupsInCommon.isEmpty)
                        const Text("You do not have any groups in common"),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

}
