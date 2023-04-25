import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/group/widgets/leave_group_button.dart';
import 'package:flutter/material.dart';

class GroupSettings extends StatelessWidget {
  const GroupSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          const RoundedListItem(child: TextField()),
          const SizedBox(height: 16),
          ClickableListItem(onClick: () {}, child: const Text("Add to group")),
          const SizedBox(height: 40),
          const Divider(indent: 16, endIndent: 16),
          const SizedBox(height: 40),
          const LeaveGroupButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
