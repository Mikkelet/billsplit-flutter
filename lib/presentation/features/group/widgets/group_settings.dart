import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/default_currency/default_group_currency_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/group_members_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/group_picture_button.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/leave_group_button.dart';
import 'package:flutter/material.dart';

class GroupSettings extends StatelessWidget {
  const GroupSettings({Key? key}) : super(key: key);
  static const double _spacing = 12;

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<GroupBloc>(
      builder: (cubit, state) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: _spacing),
            const GroupPictureButton(),
            const SizedBox(height: _spacing),
            UpdatableTextField(
              initState: cubit.group.nameState,
              updateFuture: cubit.updateGroupName,
            ),
            const SizedBox(height: _spacing),
            const GroupMembersView(),
            const SizedBox(height: _spacing),
            DefaultGroupCurrencyView(group: cubit.group),
            const SizedBox(height: _spacing),
            const LeaveGroupButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
