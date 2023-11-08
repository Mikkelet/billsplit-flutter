import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/friends/bloc/add_friend_cubit.dart';
import 'package:billsplit_flutter/presentation/features/friends/widgets/friend_accepted_view.dart';
import 'package:billsplit_flutter/presentation/features/friends/widgets/friend_request_received_view.dart';
import 'package:billsplit_flutter/presentation/features/friends/widgets/friend_request_sent_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendView extends StatelessWidget {
  final Friend friend;

  const FriendView({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFriendCubit(),
      child: RoundedListItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfilePictureView(person: friend.person),
            const SizedBox(width: 16),
            Expanded(
              child: Builder(builder: (context) {
                switch (friend.status) {
                  case FriendStatus.accepted:
                    return FriendAcceptedView(person: friend.person);
                  case FriendStatus.requestSent:
                    return FriendRequestSentView(person: friend.person);
                  default:
                    return FriendRequestReceivedView(person: friend.person);
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
