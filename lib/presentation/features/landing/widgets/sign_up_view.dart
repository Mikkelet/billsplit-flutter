import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/sign_up_cubit.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/password_textfield.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/screens/onboarding_step_welcome.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/landing_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

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
    final landingCubit = context.read<LandingBloc>();
    return BaseBlocWidget(
      listener: (context, cubit, state) {
        if (state is SignUpSuccessful) {
          Navigator.of(context).push(OnboardingStepWelcomeView.getRoute());
        }
      },
      create: (context) => SignUpCubit(),
      child: BaseBlocBuilder<SignUpCubit>(builder: (signUpCubit, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Container(height: 120),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Sign up",
                      style: Theme.of(context).textTheme.displayMedium),
                ),
                Container(height: 32),
                RoundedListItem(
                    child: TextField(
                  controller: emailFieldController,
                  style: SplitsbyTextTheme.textFieldStyle(context),
                  decoration: InputDecoration(
                    hintStyle: SplitsbyTextTheme.textFieldHintStyle(context),
                    errorText: emailError,
                    hintText: "Email",
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(height: 8),
                RoundedListItem(
                  child: PasswordTextField(
                    controller: passwordFieldController,
                    error: passwordError,
                    hintText: "Enter password (min. 6 characters)",
                  ),
                ),
                const SizedBox(height: 8),
                RoundedListItem(
                  child: PasswordTextField(
                    controller: repeatPasswordFieldController,
                    error: repeatPasswordError,
                    hintText: "Repeat password",
                  ),
                ),
                const SizedBox(height: 16),
                if (state is Loading)
                  const CircularProgressIndicator()
                else
                  SimpleButton(
                    onClick: () {
                      if (validateFields()) {
                        final String email = emailFieldController.value.text;
                        final String password =
                            passwordFieldController.value.text;
                        signUpCubit.signUp(email, password);
                      }
                      updateState();
                    },
                    child: const Text("Sign up"),
                  ),
                const SizedBox(height: 16),
                MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  onPressed: () {
                    landingCubit.showSignIn();
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                const SizedBox(height: 32)
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
