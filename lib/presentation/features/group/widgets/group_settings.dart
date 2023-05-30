import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notifications_settings_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/default_currency/default_group_currency_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/group_members_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/leave_group_button.dart';
import 'package:flutter/material.dart';

class GroupSettings extends StatelessWidget {
  const GroupSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<GroupBloc>(
      builder: (cubit, state) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            RoundedListItem(
              padding: 16,
              child: UpdatableTextField(
                initState: cubit.group.nameState,
                updateFuture: cubit.updateGroupName,
              ),
            ),
            const SizedBox(height: 4),
            const RoundedListItem(
              child: GroupMembersView(),
            ),
            const SizedBox(height: 4),
            DefaultGroupCurrencyView(group: cubit.group),
            const SizedBox(height: 4),
            SizedBox(
              height: 64,
              child: ClickableListItem(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onClick: () {
                  Navigator.of(context)
                      .push(NotificationsSettingsView.getRoute(cubit.group));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Group notifications",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Icon(Icons.arrow_right,
                        color: Theme.of(context).colorScheme.onPrimaryContainer)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Divider(indent: 16, endIndent: 16),
            const SizedBox(height: 40),
            const LeaveGroupButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
