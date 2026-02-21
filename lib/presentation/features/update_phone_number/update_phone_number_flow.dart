import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_cubit.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_state.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/steps/confirm_phone_number_page.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/steps/update_phone_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePhoneNumberFlow extends StatefulWidget {
  const UpdatePhoneNumberFlow({super.key});

  @override
  State<UpdatePhoneNumberFlow> createState() => _UpdatePhoneNumberFlowState();
}

class _UpdatePhoneNumberFlowState extends State<UpdatePhoneNumberFlow> {
  void showSuccess(BuildContext context, UpdatePhoneNumberState state) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "Success",
          text: "Your phone number has been updated to ${state.phoneNumber}",
          primaryText: "OK",
          onPrimaryClick: () {
            Navigator.of(context)
              ..pop()
              ..pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdatePhoneNumberCubit>();
    return BlocConsumer<UpdatePhoneNumberCubit, UpdatePhoneNumberState>(
      listenWhen: (prev, curr) => curr.success,
      listener: (context, state) {
        showSuccess(context, state);
      },
      builder: (context, state) {
        return BaseScaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Builder(
            builder: (context) {
              return PageView(
                controller: cubit.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  UpdatePhoneNumberPage(
                    initialCountry: state.countryCode,
                    phoneNumber: state.phoneNumber,
                  ),
                  ConfirmPhoneNumberPage(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
