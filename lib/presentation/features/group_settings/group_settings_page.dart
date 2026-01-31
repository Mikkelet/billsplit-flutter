import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_state.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/widgets/default_currency/default_group_currency_view.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/widgets/group_members_view.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/widgets/group_picture_button.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/widgets/leave_group_button.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class GroupSettings extends StatelessWidget {
  // Should not be const to force state updates
  final Group group;

  const GroupSettings({super.key, required this.group});

  static const double _spacing = 12;

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => GroupSettingsCubit(group),
      listener: (context, cubit, state) {
        if (state is GroupLeft) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      child: BaseBlocBuilder<GroupSettingsCubit>(builder: (cubit, state) {
        return BaseScaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Group settings"),
            actions: const [LeaveGroupButton(), SizedBox(width: 8)],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(height: _spacing),
                const GroupPictureButton(),
                const SizedBox(height: _spacing),
                MutableValue(
                  mutableValue: group.nameState,
                  builder: (context, value) {
                    return UpdatableTextField(
                      initState: value,
                      updateFuture: cubit.updateGroupName,
                    );
                  }
                ),
                const SizedBox(height: _spacing),
                DefaultGroupCurrencyView(group: group),
                const SizedBox(height: _spacing),
                const GroupMembersView(),
                const SizedBox(height: _spacing * 5),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }),
    );
  }

  static Route getRoute(Group group) =>
      slideUpRoute(GroupSettings(group: group));
}
