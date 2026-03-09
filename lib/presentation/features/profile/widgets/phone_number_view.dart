import 'package:billsplit_flutter/presentation/features/profile/widgets/profile_list_item.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/update_phone_number_route.dart';
import 'package:billsplit_flutter/presentation/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main_cubit.dart';

class PhoneNumberView extends StatelessWidget {
  const PhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainCubit>();
    final phoneNumber = context.user.phoneNumber;
    if (phoneNumber.phoneNumber.isEmpty) {
      return ProfileListItem(
        text: "Click here to add phone number",
        icon: null,
        onClick: () async {
          await UpdatePhoneNumberRoute().push(context);
        },
      );
    }
    return ProfileListItem(
      text: phoneNumber.display,
      icon: null,
      onClick: () async {
        await UpdatePhoneNumberRoute(phoneNumber: phoneNumber.dial).push(context);
      },
    );

  }
}
