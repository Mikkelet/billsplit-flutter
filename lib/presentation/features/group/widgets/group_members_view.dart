import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
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
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                onClick: () {
                  setState(() {
                    this.isExpanded = !this.isExpanded;
                  });
                },
                child: Builder(builder: (context) {
                  if (!isExpanded) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfilePictureStack(
                            people: cubit.group.people,
                            size: 32,
                          ),
                        ),
                        Container(
                          height: 10,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          child: Center(
                              child: Container(
                            height: 1,
                            width: 64,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          )),
                        )
                      ],
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Group Members",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
            backgroundColor: Colors.transparent,
            isExpanded: isExpanded,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RoundedListItem(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      ...cubit.group.people.mapIndexed(
                        (i, person) => Padding(
                          padding: EdgeInsets.only(top: i > 0 ? 8 : 0),
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
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                if (cubit.state is AddingPersonToGroup)
                  const Center(child: CircularProgressIndicator())
                else
                  ClickableListItem(
                    height: 48,
                    width: 48,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(30)),
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
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
              ],
            ),
            canTapOnHeader: true)
      ],
    );
  }
}
