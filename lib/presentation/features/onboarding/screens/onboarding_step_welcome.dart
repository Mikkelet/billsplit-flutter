import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_change_display_name.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class OnboardingStepWelcomeView extends StatelessWidget {
  const OnboardingStepWelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: const [CloseButton()],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 64),
            const Text(
              "Welcome!",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 64),
            SimpleButton(
              onClick: () {
                Navigator.of(context).push(OnboardingStepChangeDisplayName.getRoute());
              },
              child: const Text("Let's get started"),
            )
          ],
        ),
      ),
    );
  }

  static Route getRoute() => slideUpRoute(const OnboardingStepWelcomeView());
}
