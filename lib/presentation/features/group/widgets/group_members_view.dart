import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/dialogs/friend_picker/friend_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupMembersView extends StatefulWidget {
  const GroupMembersView({Key? key}) : super(key: key);

  @override
  State<GroupMembersView> createState() => _GroupMembersViewState();
}

class _GroupMembersViewState extends SafeState<GroupMembersView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return ExpansionPanelList(
      expandedHeaderPadding: const EdgeInsets.only(bottom: 4),
      elevation: 0,
      children: [
        // To remove the downward arrow, see:
        // https://stackoverflow.com/questions/63437671/flutter-how-to-remove-icon-from-expansion-panel
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ClickableListItem(
                alignment: Alignment.centerLeft,
                onClick: () {
                  setState(() {
                    this.isExpanded = !this.isExpanded;
                  });
                },
                child: Builder(
                  builder: (context) {
                    if(!isExpanded){
                      return ProfilePictureStack(people: cubit.group.people, size: 32,);
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Group Members",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    );
                  }
                ),
              );
            },
            backgroundColor: Colors.transparent,
            isExpanded: isExpanded,
            body: Column(
              children: [
                Column(
                  children: [
                    ...cubit.group.people.mapIndexed((i, person) => Padding(
                          padding: EdgeInsets.only(top: i > 0 ? 4 : 0),
                          child: Row(
                            children: [
                              ProfilePictureView(person: person),
                              const SizedBox(width: 8),
                              Text(
                                person.displayName,
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          ),
                        ))
                  ],
                ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(child: SizedBox()),
                          Icon(
                            Icons.add,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          )
                        ],
                      ))
              ],
            ),
            canTapOnHeader: true)
      ],
    );
  }
}
