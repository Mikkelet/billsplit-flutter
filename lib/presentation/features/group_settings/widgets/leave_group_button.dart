import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaveGroupButton extends StatelessWidget {
  const LeaveGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupSettingsCubit>();
    return SizedBox(
      height: 48,
      child: TextButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => CustomDialog(
              text: "Are you sure you want to leave ${cubit.group.nameState}?",
              onPrimaryClick: () {
                Navigator.of(context).pop();
              },
              primaryText: "No",
              secondaryText: "Yes, I want to leave",
              onSecondaryClick: () {
                cubit.leaveGroup();
              },
            ),
          );
        },
        child: Text(
          "Leave",
          style: SplitsbyTextTheme.leaveGroupText(context),
        ),
      ),
    );
  }
}
