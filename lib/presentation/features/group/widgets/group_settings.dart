import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/dialogs/friend_picker/friend_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notifications_settings_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/leave_group_button.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSettings extends StatelessWidget {
  const GroupSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          RoundedListItem(
            child: UpdatableTextField(
                initState: cubit.group.nameState,
                state: cubit.editGroupNameState,
                onEditPressed: () {
                  cubit.editGroupName(true);
                },
                onCancelPressed: () {
                  cubit.editGroupName(false);
                },
                onUpdateClicked: () {
                  cubit.updateGroupName();
                },
                onChange: (val) {
                  cubit.group.nameState = val;
                }),
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
          const SizedBox(height: 16),
          ClickableListItem(
            onClick: () {
              Navigator.of(context)
                  .push(NotificationsSettingsView.getRoute(cubit.group));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Group notifications"),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
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
