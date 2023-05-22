import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return ClickableListItem(
      onClick: () async {
        final response = await showDialog(
            context: context,
            builder: (context) {
              return const CustomDialog(
                title: "Are you sure your want to log out?",
                primaryText: "Yes, log me out",
                secondaryText: "No",
              );
            });
        if (response == true) {
          cubit.signOut();
        }
      },
      color: Theme.of(context).colorScheme.error,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Sign out",
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
      ),
    );
  }
}
