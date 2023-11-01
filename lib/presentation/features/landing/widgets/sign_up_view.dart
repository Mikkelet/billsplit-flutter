import 'dart:io';

import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_cubit.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/password_textfield.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/onboarding_flow.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends SafeState<SignUpView> {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final repeatPasswordFieldController = TextEditingController();
  String? emailError;
  String? passwordError;
  String? repeatPasswordError;

  @override
  void initState() {
    emailFieldController.addListener(() {
      _resetEmailError();
    });
    passwordFieldController.addListener(() {
      _resetPasswordError();
    });
    repeatPasswordFieldController.addListener(() {
      _resetRepeatPasswordError();
    });
    super.initState();
  }

  _resetEmailError() {
    if (emailError != null) {
      setState(() {
        emailError = null;
      });
    }
  }

  _resetRepeatPasswordError() {
    if (repeatPasswordError != null) {
      setState(() {
        repeatPasswordError = null;
      });
    }
  }

  _resetPasswordError() {
    if (passwordError != null) {
      setState(() {
        passwordError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => LandingCubit(),
      listener: (context, cubit, state) {
        if (state is SignUpSuccessful) {
          Navigator.of(context).push(OnboardingFlow.getRoute());
        }
      },
      child: BaseBlocBuilder<LandingCubit>(builder: (signUpCubit, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RoundedListItem(
                    height: 64,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                      bottom: Radius.circular(10),
                    ),
                    child: TextField(
                      controller: emailFieldController,
                      style: SplitsbyTextTheme.textFieldStyle(context),
                      decoration: InputDecoration(
                        hintStyle:
                            SplitsbyTextTheme.textFieldHintStyle(context),
                        errorStyle:
                            SplitsbyTextTheme.textFieldErrorText(context),
                        errorText: emailError,
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
                    )),
                const SizedBox(height: 4),
                PasswordTextField(
                  controller: passwordFieldController,
                  error: passwordError,
                  hintText: "Enter password (min. 6 characters)",
                ),
                const SizedBox(height: 4),
                PasswordTextField(
                  controller: repeatPasswordFieldController,
                  error: repeatPasswordError,
                  hintText: "Repeat password",
                ),
                const SizedBox(height: 4),
                if (state is Loading)
                  const Center(child: CircularProgressIndicator())
                else
                  ClickableListItem(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(30)),
                    height: 48,
                    width: 128,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    onClick: () {
                      if (validateFields()) {
                        final String email = emailFieldController.value.text;
                        final String password =
                            passwordFieldController.value.text;
                        signUpCubit.signUpWithEmail(email, password);
                      }
                      updateState();
                    },
                    child: Text(
                      "Sign up",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                const SizedBox(height: 32),
                if (Platform.isIOS)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.apple),
                      TextButton(
                        onPressed: () {
                          signUpCubit.signInWithApple();
                        },
                        child: const Text("Sign in with Apple"),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        signUpCubit.signInWithGoogle();
                      },
                      child: const Text("Sign in with Google"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  bool validateFields() {
    validateEmail();
    validatePassword();
    validateRepeatPassword();
    return emailError == null &&
        passwordError == null &&
        repeatPasswordError == null;
  }

  validateEmail() {
    if (emailFieldController.text.isEmpty) {
      emailError = "Enter email";
    } else if (!EmailValidator.validate(emailFieldController.text)) {
      emailError = "Invalid email";
    } else {
      emailError = null;
    }
  }

  validatePassword() {
    if (passwordFieldController.text.isEmpty) {
      passwordError = "Enter a password";
    } else if (passwordFieldController.text.length < 6) {
      passwordError = "Password is too short (min 6 characters)";
    } else {
      passwordError = null;
    }
  }

  validateRepeatPassword() {
    if (repeatPasswordFieldController.text.isEmpty) {
      repeatPasswordError = "Repeat your password";
    } else if (repeatPasswordFieldController.text !=
        passwordFieldController.text) {
      repeatPasswordError = "Passwords do not match";
    } else {
      repeatPasswordError = null;
    }
  }
}
