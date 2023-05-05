import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaveGroupButton extends StatelessWidget {
  const LeaveGroupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();

    return ClickableListItem(
      color: Theme.of(context).colorScheme.error,
      onClick: () async {
        await showDialog(
          context: context,
          builder: (context) => CustomDialog(
            text: "Are you sure you want to leave ${cubit.group.nameState}?",
            onPrimaryClick: () {
              Navigator.of(context).pop();
            },
            primaryText: "No",
            secondaryText: "Yes, I want to leave",
            onSecondaryClick: () {
              cubit.leaveGroup();
            },
          ),
        );
      },
      child: Text(
        "Leave group",
        style: TextStyle(color: Theme.of(context).colorScheme.onError),
      ),
    );
  }
}
