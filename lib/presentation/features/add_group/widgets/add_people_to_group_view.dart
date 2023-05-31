import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/friend_picker/friend_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_group_cubit.dart';

class AddPeopleToGroupView extends StatelessWidget {
  const AddPeopleToGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddGroupCubit>();
    return ClickableListItem(
        height: 48,
        width: 48,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(30)),
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: const Icon(Icons.group_add),
        onClick: () {
          showDialog(
              context: context,
              builder: (dialogContext) => FriendPickerDialog(
                    onFriendAdded: (friend) {
                      cubit.onAddPerson(friend);
                      Navigator.of(context).pop();
                    },
                    currentPickedFriends: cubit.people,
                  ));
        });
  }
}
