import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/bloc/update_name_cubit.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_upload_pfp_screen.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class OnboardingStepChangeDisplayName extends StatelessWidget {
  const OnboardingStepChangeDisplayName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<UpdateNameCubit>(
      create: (context) => UpdateNameCubit(),
      child: BaseBlocBuilder<UpdateNameCubit>(builder: (cubit, state) {
        return Scaffold(
          appBar: AppBar(
            leading: null,
            actions: [
              CloseButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(height: 64),
                  const Text(
                    "What's your name?",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 64),
                  UpdatableTextField(
                      initState: cubit.user.nameState,
                      hintText: "Your name",
                      updateFuture: cubit.updateName),
                  const SizedBox(height: 64),
                  SimpleButton(
                    onClick: () {
                      Navigator.of(context)
                          .push(OnboardingStepUploadProfilePicture.getRoute());
                    },
                    child: const Text("Next"),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  static Route getRoute() =>
      slideLeftRoute(const OnboardingStepChangeDisplayName());
}
