import 'package:billsplit_flutter/presentation/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/widgets/next_step_button.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/phone_number_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingStepPhoneNumber extends StatelessWidget {
  const OnboardingStepPhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingBloc>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Do you want to add a phone number?",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 16),
          Text(
            "People can use this to easily add you as friend. It will also unlock some payment features depending on your region.",
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 32),
          PhoneNumberView<OnboardingBloc>(),
          const SizedBox(height: 64),
          NextStepButton(cubit.nextButtonText(this))
        ],
      ),
    );
  }
}
