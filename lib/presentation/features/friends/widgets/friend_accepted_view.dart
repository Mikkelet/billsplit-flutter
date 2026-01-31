import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:flutter/material.dart';

class FriendAcceptedView extends StatelessWidget {
  final Person person;

  const FriendAcceptedView({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity, child: Text(person.displayName));
  }
}
