import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';

class DisplayNameTextField extends StatelessWidget {
  const DisplayNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<ProfileCubit>(
      builder: (cubit, state) {
        return UpdatableTextField(
          initState: cubit.user.nameState,
          state: cubit.updateDisplayNameState,
          charLimit: 20,
          onEditPressed: () {
            cubit.editDisplayName(true);
          },
          onCancelPressed: () {
            cubit.editDisplayName(false);
          },
          onUpdateClicked: (value) {
            cubit.updateDisplayName(value);
          },
        );
      },
    );
  }
}
