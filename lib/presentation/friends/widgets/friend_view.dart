import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:flutter/material.dart';

class FriendView extends StatelessWidget {
  final Friend friend;
  const FriendView({Key? key, required this.friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(friend.person.name),
      Text(friend.status.name)
    ],);
  }
}
