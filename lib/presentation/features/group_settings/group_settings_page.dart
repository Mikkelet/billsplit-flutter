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
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSettings extends StatelessWidget {
  // Should not be const to force state updates

  const GroupSettings({super.key});

  static const double _spacing = 12;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupSettingsCubit>();
    return BlocBuilder<GroupSettingsCubit, GroupSettingsState>(
      builder: (context, state) {
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
                  mutableValue: cubit.group.nameState,
                  builder: (context, value) {
                    return UpdatableTextField(
                      initState: value,
                      updateFuture: cubit.updateGroupName,
                    );
                  },
                ),
                const SizedBox(height: _spacing),
                const DefaultGroupCurrencyView(),
                const SizedBox(height: _spacing),
                const GroupMembersView(),
                const SizedBox(height: _spacing * 5),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}
