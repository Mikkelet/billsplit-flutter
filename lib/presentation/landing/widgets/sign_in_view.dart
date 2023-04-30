import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/landing/bloc/landing_bloc.dart';
import 'package:billsplit_flutter/presentation/landing/widgets/password_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
    final cubit = context.read<LandingBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(height: 120),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Sign in",
                  style: Theme.of(context).textTheme.displayMedium),
            ),
            Container(height: 32),
            RoundedListItem(
                child: TextField(
              controller: emailFieldController,
              decoration: InputDecoration(
                errorText: emailError,
                hintText: "Email",
                border: InputBorder.none,
              ),
            )),
            const SizedBox(height: 16),
            RoundedListItem(
              child: PasswordTextField(
                controller: passwordFieldController,
                error: passwordError,
                hintText: "Repeat password",
              ),
            ),
            const SizedBox(height: 16),
            SimpleButton(
              onClick: () {
                if (validateFields()) {
                  _onPressed(context);
                }
                setState(() {});
              },
              child: const Text("Sign in"),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () {
                cubit.showSignUp();
              },
              child: const Text("Create an account"),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  _onPressed(BuildContext context) {
    final String email = emailFieldController.value.text;
    final String password = passwordFieldController.value.text;
    final cubit = context.read<LandingBloc>();
    cubit.signIn(email, password);
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
