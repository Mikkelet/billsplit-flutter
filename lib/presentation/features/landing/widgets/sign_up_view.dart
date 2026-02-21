import 'dart:io';

import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_cubit.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/guest_signin_button.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/password_textfield.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/sign_in_with_apple_button.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/sign_in_with_google_button.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/onboarding_flow.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LandingCubit>();
    return BlocBuilder<LandingCubit, LandingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedListItem(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                    bottom: Radius.circular(0),
                  ),
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
                  error: state.passwordError,
                  borderRadius: const BorderRadius.all(Radius.zero),
                  hintText: "Enter password (min. 6 characters)",
                ),
                PasswordTextField(
                  controller: cubit.repeatPasswordFieldController,
                  error: state.repeatPasswordError,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(0),
                    bottom: Radius.circular(10),
                  ),
                  hintText: "Repeat password",
                ),
                const SizedBox(height: 4),
                if (state is Loading)
                  const Center(child: CircularProgressIndicator())
                else
                  Row(
                    children: [
                      const Spacer(),
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
                          cubit.signUpWithEmail();
                        },
                        child: Text(
                          "Sign up",
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
