import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/friend_picker/friend_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:billsplit_flutter/presentation/group/widgets/leave_group_button.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSettings extends StatefulWidget {
  const GroupSettings({Key? key}) : super(key: key);

  @override
  State<GroupSettings> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  final groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    groupNameController.text = cubit.group.name;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          RoundedListItem(
            child: TextField(
              maxLines: 1,
              maxLength: 40,
              controller: groupNameController,
              decoration: const InputDecoration(
                  counterText: "", border: InputBorder.none),
            ),
          ),
          const SizedBox(height: 16),
          RoundedListItem(
            child: Column(
              children: [
                ...cubit.group.people.mapIndexed((index, person) => Padding(
                      padding: EdgeInsets.only(top: index > 0 ? 8 : 0),
                      child: Row(
                        children: [
                          ProfilePictureView(person: person),
                          const SizedBox(width: 8),
                          Text(person.nameState)
                        ],
                      ),
                    ))
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (cubit.state is AddingPersonToGroup)
            const Center(child: CircularProgressIndicator())
          else
            ClickableListItem(
                onClick: () async {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => FriendPickerDialog(
                      onFriendAdded: (friend) {
                        cubit.addPersonToGroup(friend);
                        Navigator.of(context).pop();
                      },
                      currentPickedFriends: cubit.group.people,
                    ),
                  );
                },
                child: const Text("Add to group")),
          const SizedBox(height: 40),
          const Divider(indent: 16, endIndent: 16),
          const SizedBox(height: 40),
          const LeaveGroupButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }
}
