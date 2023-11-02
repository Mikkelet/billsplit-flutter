import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
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
          return TextButton(
            onPressed: () async {
              await Navigator.of(context)
                  .push(UpdatePhoneNumberFlow.getRoute());
              cubit.update();
            },
            child: const Text("Click here to add phone number"),
          );
        }
        return ClickableListItem(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 64,
          child: Text(
            phoneNumber.display,
            style: Theme.of(context).textTheme.labelLarge,
          ),
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
