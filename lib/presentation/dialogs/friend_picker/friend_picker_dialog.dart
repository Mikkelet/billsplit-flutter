import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/dialogs/friend_picker/friend_picker_cubit.dart';
import 'package:billsplit_flutter/presentation/dialogs/friend_picker/no_friends_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/person_picker_dialog.dart';
import 'package:flutter/material.dart';

class FriendPickerDialog extends StatelessWidget {
  final Iterable<Person> currentPickedFriends;
  final Function(Person) onFriendAdded;

  const FriendPickerDialog(
      {Key? key,
      required this.onFriendAdded,
      required this.currentPickedFriends})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BaseBlocWidget<FriendPickerCubit>(
        create: (context) => FriendPickerCubit(currentPickedFriends),
        child: BaseBlocBuilder<FriendPickerCubit>(
          builder: (cubit, state) {
            return DefaultStreamBuilder(
              stream: cubit.friendsStream,
              builder: (_, friends) {
                if (friends.isEmpty) {
                  return const NoFriendsDialog();
                }
                return PersonPickerDialog(
                    people: friends.toList(),
                    onClick: (friend) {
                      onFriendAdded(friend);
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
