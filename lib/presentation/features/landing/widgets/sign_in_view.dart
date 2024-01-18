import 'dart:io';

import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_cubit.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/forgot_password_button.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/password_textfield.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends SafeState<SignInView> {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  bool showPassword = false;
  String? emailError;
  String? passwordError;

  @override
  void initState() {
    emailFieldController.addListener(() {
      _resetEmailError();
    });
    passwordFieldController.addListener(() {
      _resetPasswordError();
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
      child: BaseBlocBuilder<LandingCubit>(builder: (signInCubit, signInState) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                RoundedListItem(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                    bottom: Radius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 64,
                  child: TextField(
                    controller: emailFieldController,
                    style: SplitsbyTextTheme.textFieldStyle(context),
                    decoration: InputDecoration(
                      hintStyle: SplitsbyTextTheme.textFieldHintStyle(context),
                      errorStyle: SplitsbyTextTheme.textFieldErrorText(context),
                      errorText: emailError,
                      hintText: "Email",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                PasswordTextField(
                  controller: passwordFieldController,
                  error: passwordError,
                  hintText: "Password",
                ),
                const SizedBox(height: 4),
                if (signInState is Loading)
                  const CircularProgressIndicator()
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ForgotPasswordButton(
                          emailController: emailFieldController),
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
                            final String email =
                                emailFieldController.value.text;
                            final String password =
                                passwordFieldController.value.text;
                            signInCubit.signInWithEmail(email, password);
                          }
                          updateState();
                        },
                        child: Text(
                          "Sign in",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 32),
                if (Platform.isIOS)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.apple),
                      TextButton(
                        onPressed: () {
                          signInCubit.signInWithApple();
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
                        signInCubit.signInWithGoogle();
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
    return emailError == null && passwordError == null;
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
}
