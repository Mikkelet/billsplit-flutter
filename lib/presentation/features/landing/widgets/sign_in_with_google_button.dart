import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LandingCubit>();
    return SimpleButton(
      color: Colors.redAccent,
      onClick: () {
        cubit.signInWithGoogle();
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sign in with Google"),
        ],
      ),
    );
  }
}
