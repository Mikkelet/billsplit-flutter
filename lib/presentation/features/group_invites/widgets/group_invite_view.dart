import 'package:billsplit_flutter/domain/models/group_invite.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/loading_view.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/group_invites/bloc/group_invite_cubit.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/group_picture.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/group_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupInviteView extends StatelessWidget {
  final GroupInvite groupInvite;

  const GroupInviteView({super.key, required this.groupInvite});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupInvitesCubit>();
    final group = groupInvite.group;
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 10,
            spreadRadius: 1,
            color: Colors.black12,
            offset: Offset(0, 8))
      ]),
      child: Center(
        child: RoundedListItem(
          color: Theme.of(context).colorScheme.primaryContainer,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  GroupPictureView(group: group),
                  GroupTitleView(group: group)
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfilePictureStack(
                            people: group.people,
                            size: 30,
                            limit: 3,
                          ),
                        ],
                      ),
                      Center(
                        child: LoadingView(
                          isLoading: groupInvite.syncState == SyncState.pending,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClickableListItem(
                                onClick: () {
                                  cubit.respond(group, false);
                                },
                                child: Text(
                                  "Decline",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              ClickableListItem(
                                onClick: () {
                                  cubit.respond(group, true);
                                },
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                child: Text(
                                  "Accept",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
