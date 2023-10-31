import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/update_phone_number_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberView extends StatelessWidget {
  const PhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return FutureBuilder(
      future: cubit.getPhoneNumber(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          cubit.showError(snapshot.error, snapshot.stackTrace);
        }
        if (snapshot.data == null) {
          return TextButton(
              onPressed: () {
                Navigator.of(context).push(UpdatePhoneNumberFlow.getRoute());
              },
              child: const Text("Click here to add phone number"));
        }
        return ClickableListItem(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 64,
          child: Text(
            snapshot.data!.display,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          onClick: () {
            Navigator.of(context).push(UpdatePhoneNumberFlow.getRoute(phoneNumber: snapshot.data!));
          },
        );
      },
    );
  }
}
