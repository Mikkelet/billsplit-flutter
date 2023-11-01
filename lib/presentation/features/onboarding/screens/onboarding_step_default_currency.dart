import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/common/update_currency/update_user_default_currency_view.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/onboarding_bloc.dart';

class OnboardingStepDefaultCurrency extends StatelessWidget {
  const OnboardingStepDefaultCurrency({super.key});

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
              const Text(
                "What's your preferred currency?",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 64),
              const UpdateUserDefaultCurrencyView(),
              const SizedBox(height: 64),
              SimpleButton(
                onClick: () {
                  cubit.submitProfile();
                },
                child: const Text("I'm ready!"),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Route getRoute() =>
      slideLeftRoute(const OnboardingStepDefaultCurrency());
}
