import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextStepButton extends StatelessWidget {
  final String text;
  const NextStepButton(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingBloc>();
    return SimpleButton(
      onClick: () {
        cubit.onNextClicked();
      },
      child: Text(text),
    );
  }
}
