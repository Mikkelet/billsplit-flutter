import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSettings extends StatelessWidget {
  const GroupSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return Column(
      children: [
        ClickableListItem(
          color: Theme.of(context).colorScheme.error,
          onClick: () {
            cubit.leaveGroup();
          },
          child: const Text("Leave group"),
        )
      ],
    );
  }
}
