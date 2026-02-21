import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/dialogs/friend_picker/friend_picker_cubit.dart';
import 'package:billsplit_flutter/presentation/dialogs/friend_picker/no_friends_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/person_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendPickerDialog extends StatelessWidget {
  final List<Person> currentPickedFriends;
  final Function(Person) onFriendAdded;

  const FriendPickerDialog({
    super.key,
    required this.onFriendAdded,
    required this.currentPickedFriends,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendPickerCubit(currentPickedFriends),
      child: BlocBuilder<FriendPickerCubit, FriendsPickerState>(
        builder: (cubit, state) {
          final cubit = context.read<FriendPickerCubit>();
          return Builder(
            builder: (context) {
              return DefaultStreamBuilder(
                stream: cubit.friendsStream,
                builder: (_, friends) {
                  if (friends.isEmpty) {
                    return const NoFriendsDialog();
                  }
                  return PersonPickerDialog(
                    people: friends,
                    onClick: (friend) {
                      onFriendAdded(friend);
                    },
                  );
                },
              );
            }
          );
        },
      ),
    );
  }
}
