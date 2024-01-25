import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignButton extends StatelessWidget {
  const AppleSignButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LandingCubit>();
    return SignInWithAppleButton(
        onPressed: () {
          cubit.signInWithApple();
        },
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        height: 50);
  }
}
