import 'package:flutter/material.dart';

import '../../../domain/models/group.dart';
import '../../group/group_page.dart';

class GroupView extends StatelessWidget {
  final Group group;

  const GroupView({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.cyan,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(GroupPage.route, arguments: {"group_id": group.id});
          },
          child: Column(
            children: [
              Text(group.name),
              Text(group.createdBy.name),
            ],
          ),
        ),
      ),
    );
  }
}
