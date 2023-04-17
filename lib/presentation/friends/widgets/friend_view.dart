import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/friends/bloc/add_friend_cubit.dart';
import 'package:billsplit_flutter/presentation/friends/widgets/friend_accepted_view.dart';
import 'package:billsplit_flutter/presentation/friends/widgets/friend_request_received_view.dart';
import 'package:billsplit_flutter/presentation/friends/widgets/friend_request_sent_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendView extends StatelessWidget {
  final Friend friend;

  const FriendView({Key? key, required this.friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFriendCubit(),
      child: RoundedListItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: ClipOval(
                child: CachedNetworkImage(
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, err) => Text("${err}"),
                  fit: BoxFit.cover,
                  imageUrl: friend.person.pfpUrl,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: builder(() {
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

/**
 *  ClipOval(
    child: Image.network(
    height: 80,
    width: 80,
    fit: BoxFit.fitWidth,
    friend.person.pfpUrl,
    ),
    ),
 */
}
