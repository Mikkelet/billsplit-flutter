import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_cubit.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_state.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/steps/confirm_phone_number_page.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/steps/update_phone_number_page.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class UpdatePhoneNumberFlow extends StatefulWidget {
  final PhoneNumber? phoneNumber;

  const UpdatePhoneNumberFlow({super.key, required this.phoneNumber});

  @override
  State<UpdatePhoneNumberFlow> createState() => _UpdatePhoneNumberFlowState();

  static Route getRoute({PhoneNumber? phoneNumber}) =>
      slideUpRoute(UpdatePhoneNumberFlow(phoneNumber: phoneNumber));
}

class _UpdatePhoneNumberFlowState extends State<UpdatePhoneNumberFlow> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      listener: (context, cubit, state) {
        if (state is UpdateStep) {
          _pageController.animateToPage(state.step,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear);
        } else if (state is UpdateNumberSuccess) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                title: "Success",
                text:
                    "Your phone number has been updated to ${cubit.phoneNumber}",
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
      },
      create: (context) => UpdatePhoneNumberCubit(widget.phoneNumber),
      child: BaseBlocBuilder<UpdatePhoneNumberCubit>(builder: (cubit, state) {
        return BaseScaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Builder(builder: (context) {
            return PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                UpdatePhoneNumberPage(
                  initialCountry: cubit.selectedCountry,
                  phoneNumber: cubit.phoneNumber,
                ),
                ConfirmPhoneNumberPage(),
              ],
            );
          }),
        );
      }),
    );
  }
}
