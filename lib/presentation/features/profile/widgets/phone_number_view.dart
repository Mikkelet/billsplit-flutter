import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/profile_list_item.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/update_phone_number_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberView<T extends BaseCubit> extends StatelessWidget {
  PhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<T>();
    final phoneNumber = cubit.user.phoneNumberState;

    return Builder(
      builder: (context) {
        if (phoneNumber.phoneNumber.isEmpty) {
          return ProfileListItem(
            text: "Click here to add phone number",
            icon: null,
            onClick: () async {
              await Navigator.of(context)
                  .push(UpdatePhoneNumberFlow.getRoute());
              cubit.update();
            },
          );
        }
        return ProfileListItem(
          text: phoneNumber.display,
          icon: null,
          onClick: () async {
            await Navigator.of(context)
                .push(UpdatePhoneNumberFlow.getRoute(phoneNumber: phoneNumber));
            cubit.update();
          },
        );
      },
    );
  }
}
