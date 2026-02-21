import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_cubit.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordButton extends StatelessWidget {
  final TextEditingController emailController;

  const ForgotPasswordButton({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingCubit, LandingState>(
      builder: (cubit, state) {
        if (state is Loading) {
          return const CircularProgressIndicator();
        }
        return MaterialButton(
          onPressed: () {
            // cubit.forgotPassword(emailController.text);
          },
          child: Text(
            "I forgot my password",
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        );
      },
    );
  }
}
