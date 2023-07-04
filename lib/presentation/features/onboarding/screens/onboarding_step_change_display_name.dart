import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/onboarding_bloc.dart';

class OnboardingStepChangeDisplayName extends StatefulWidget {
  const OnboardingStepChangeDisplayName({Key? key}) : super(key: key);

  @override
  State<OnboardingStepChangeDisplayName> createState() =>
      _OnboardingStepChangeDisplayNameState();

  static Route getRoute() =>
      slideLeftRoute(const OnboardingStepChangeDisplayName());
}

class _OnboardingStepChangeDisplayNameState
    extends State<OnboardingStepChangeDisplayName> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingBloc>();

    return Center(
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
            RoundedListItem(
                child: TextField(
              autofocus: true,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.labelLarge?.fontSize),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your name",
                counterText: "",
              ),
              maxLines: 1,
              maxLength: 40,
              controller: textController..text = cubit.name,
              onChanged: (value) {
                cubit.onNameChanged(value);
              },
            )),
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
    );
  }
}
