import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/forgot_password_cubit.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  final TextEditingController emailController;

  const ForgotPasswordButton({Key? key, required this.emailController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => ForgotPasswordCubit(),
      listener: (context, cubit, state) {
        if (state is ResetPasswordSent) {
          showDialog(
              context: context,
              builder: (context) {
                return const CustomDialog(
                    title: "Reset password confirmed",
                    text:
                        "An URL to reset your password has been sent to your email");
              });
        }
      },
      child: BaseBlocBuilder<ForgotPasswordCubit>(builder: (cubit, state) {
        if (state is Loading) {
          return const CircularProgressIndicator();
        }
        return MaterialButton(
          onPressed: () {
            cubit.forgotPassword(emailController.text);
          },
          child: Text("I forgot my password",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        );
      }),
    );
  }
}
