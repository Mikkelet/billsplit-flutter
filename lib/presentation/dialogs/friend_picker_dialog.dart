import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/add_group/bloc/add_group_cubit.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/add_group/widgets/no_friends_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/person_picker_dialog.dart';
import 'package:flutter/material.dart';

class FriendPickerDialog extends StatelessWidget {
  final Function(Person) onFriendAdded;
  final AddGroupCubit cubit;

  const FriendPickerDialog({Key? key, required this.onFriendAdded, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: DefaultStreamBuilder(
        stream: cubit.friendsStream,
        body: (friends) {
          if (friends.isEmpty) {
            return NoFriendsDialog(cubit: cubit,);
          }
          return PersonPickerDialog(
              people: friends.toList(),
              onClick: (friend) {
                onFriendAdded(friend);
              });
        },
      ),
    );
  }
}
