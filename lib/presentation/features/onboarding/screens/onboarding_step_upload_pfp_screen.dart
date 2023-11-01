import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/common/upload_profile_picture/upload_pfp_view.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/onboarding_bloc.dart';

class OnboardingStepUploadProfilePicture extends StatelessWidget {
  const OnboardingStepUploadProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingBloc>();

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 64),
              Text(
                cubit.greeting,
                style: const TextStyle(fontSize: 25),
              ),
              const Text(
                "What do you look like?",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 64),
              const UploadProfilePictureView(),
              const SizedBox(height: 64),
              SimpleButton(
                onClick: () {
                  cubit.onNextClicked();
                },
                child: const Text("Next"),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Route getRoute() =>
      slideLeftRoute(const OnboardingStepUploadProfilePicture());
}
