import 'package:billsplit_flutter/presentation/common/update_textfield/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/default_currency/default_group_currency_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/group_members_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/group_picture_button.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/leave_group_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSettings extends StatelessWidget {
  const GroupSettings({Key? key}) : super(key: key);
  static const double _spacing = 12;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: _spacing),
          GroupPictureButton(),
          const SizedBox(height: _spacing),
          UpdatableTextField(
            initState: cubit.group.nameState,
            updateFuture: cubit.updateGroupName,
          ),
          const SizedBox(height: _spacing),
          GroupMembersView(),
          const SizedBox(height: _spacing),
          DefaultGroupCurrencyView(group: cubit.group),
          const SizedBox(height: _spacing),
          const LeaveGroupButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
