import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/common/upload_profile_picture/upload_pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_default_currency.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class OnboardingStepUploadProfilePicture extends StatelessWidget {
  const OnboardingStepUploadProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          CloseButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 64),
              const Text(
                "What's do you look like?",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 64),
              const UploadProfilePictureView(),
              const SizedBox(height: 64),
              SimpleButton(
                onClick: () {
                  Navigator.of(context)
                      .push(OnboardingStepDefaultCurrency.getRoute());
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
