import 'dart:io';

import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_cubit.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/forgot_password_button.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/guest_signin_button.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/password_textfield.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/sign_in_with_apple_button.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/sign_in_with_google_button.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/landing_state.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LandingCubit>();
    return BlocBuilder<LandingCubit, LandingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                RoundedListItem(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                    bottom: Radius.circular(0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 64,
                  child: TextField(
                    controller: cubit.emailFieldController,
                    style: SplitsbyTextTheme.textFieldStyle(context),
                    decoration: InputDecoration(
                      hintStyle: SplitsbyTextTheme.textFieldHintStyle(context),
                      errorStyle: SplitsbyTextTheme.textFieldErrorText(context),
                      errorText: state.emailError,
                      hintText: "Email",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                PasswordTextField(
                  controller: cubit.passwordFieldController,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.zero,
                    bottom: Radius.circular(10),
                  ),
                  error: state.passwordError,
                  hintText: "Password",
                ),
                const SizedBox(height: 4),
                if (state.isLoading)
                  const CircularProgressIndicator()
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ForgotPasswordButton(emailController: cubit.emailFieldController),
                      ClickableListItem(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(30),
                        ),
                        height: 48,
                        width: 128,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        onClick: () {
                          cubit.signInWithEmail();
                        },
                        child: Text(
                          "Sign in",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 32),
                if (Platform.isIOS) const AppleSignButton(),
                const SizedBox(height: 8),
                const SignInWithGoogleButton(),
                const SizedBox(height: 8),
                const GuestSignInButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
