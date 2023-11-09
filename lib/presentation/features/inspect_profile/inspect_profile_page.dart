import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/group_view.dart';
import 'package:billsplit_flutter/presentation/features/inspect_profile/bloc/inspect_profile_cubit.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class InspectProfilePage extends StatelessWidget {
  final Person person;

  const InspectProfilePage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => InspectProfileCubit(person),
      child: BaseBlocBuilder<InspectProfileCubit>(builder: (cubit, state) {
        return BaseScaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Builder(builder: (context) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 32),
                      ProfilePictureView(person: person, size: 100),
                      const SizedBox(height: 16),
                      Text(
                        person.displayName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 32),
                      if (cubit.friendStatus == FriendStatus.notFriends)
                        TextButton(
                            onPressed: cubit.addFriend,
                            child: const Text("Add friend")),
                      if (cubit.friendStatus == FriendStatus.accepted)
                        const Text("You are friends"),
                      if (cubit.friendStatus == FriendStatus.yourself)
                        const Text("Looking good!"),
                      if (cubit.friendStatus == FriendStatus.requestReceived)
                        Row(
                          children: [
                            TextButton(
                                onPressed: () =>
                                    cubit.respondToFriendRequest(true),
                                child: const Text("Accept")),
                            TextButton(
                                onPressed: () =>
                                    cubit.respondToFriendRequest(false),
                                child: const Text("Reject"))
                          ],
                        ),
                      if (cubit.friendStatus == FriendStatus.requestSent)
                        const Text("Invite sent"),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Groups in common",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (cubit.groupsInCommon.isNotEmpty)
                        ...cubit.groupsInCommon.map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: GroupView(group: e, debtToGroup: 0),
                            )),
                      if(cubit.groupsInCommon.isEmpty)
                        const Text("You do not have any groups in common")
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  static Route getRoute(Person person) =>
      slideUpRoute(InspectProfilePage(person: person));
}
