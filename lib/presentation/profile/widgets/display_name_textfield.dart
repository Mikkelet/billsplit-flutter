import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/profile/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';

class DisplayNameTextField extends StatelessWidget {
  const DisplayNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<ProfileCubit>(
      builder: (cubit, state) => UpdatableTextField(
        initState: cubit.user.nameState,
        charLimit: 20,
        state: cubit.updateDisplayNameState,
        onUpdateClicked: () {
          cubit.updateDisplayName();
        },
        onEditPressed: () {
          cubit.editDisplayName(true);
        },
        onCancelPressed: () {
          cubit.editDisplayName(false);
        },
        onChange: (value) {
          cubit.user.nameState = value;
        },
      ),
    );
  }
}
