import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingStepWelcomeView extends StatelessWidget {
  const OnboardingStepWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingBloc>();
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 64),
          const Text(
            "Welcome!",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              "We're very excited for you to try our app! First, let's make sure that others can recognize you, and that Splitsby has the right permissions! 🙌",
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 64),
          SimpleButton(
            onClick: () {
              cubit.onNextClicked();
            },
            child: const Text("Let's get started"),
          )
        ],
      ),
    );
  }
}
