import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/upload_profile_picture/upload_pfp_cubit.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadProfilePictureView extends StatelessWidget {
  const UploadProfilePictureView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadProfilePictureCubit(),
      child: BlocBuilder<UploadProfilePictureCubit, UploadProfilePictureState>(
        builder: (cubit, state) {
          final cubit = context.read<UploadProfilePictureCubit>();
          return GestureDetector(
            onTap: () {
              cubit.updateProfilePicture();
            },
            onLongPress: () async {
              final response = await showDialog(
                context: context,
                builder: (context) => CustomDialog(
                  title: "Delete profile picture?",
                  primaryText: "Yes, Delete",
                  onPrimaryClick: () {
                    Navigator.of(context).pop(true);
                  },
                  secondaryText: "No",
                  onSecondaryClick: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              );
              if (response == true) {
                cubit.deleteProfilePicture();
              }
            },
            child: Builder(
              builder: (context) {
                if (state is Loading) {
                  return const SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(),
                  );
                }
                return ProfilePictureView(person: context.user, size: 120);
              },
            ),
          );
        },
      ),
    );
  }
}
