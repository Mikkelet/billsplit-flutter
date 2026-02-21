import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:flutter/material.dart';

class FriendRequestSentView extends StatelessWidget {
  final Person person;

  const FriendRequestSentView({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return RoundedListItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(person.displayName),
          const Text("Request sent"),
        ],
      ),
    );
  }
}
