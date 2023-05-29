import 'package:billsplit_flutter/presentation/dialogs/friend_picker/friend_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_group_cubit.dart';

class AddPeopleToGroupView extends StatelessWidget {
  const AddPeopleToGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddGroupCubit>();
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (dialogContext) => FriendPickerDialog(
                      onFriendAdded: (friend) {
                        cubit.onAddPerson(friend);
                        Navigator.of(context).pop();
                      },
                      currentPickedFriends: cubit.people,
                    ));
          }),
    );
  }
}
