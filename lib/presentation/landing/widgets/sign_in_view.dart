import 'package:billsplit_flutter/presentation/landing/bloc/landing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(height: 120),
          TextField(controller: emailFieldController),
          TextField(controller: passwordFieldController),
          ElevatedButton(
              onPressed: () {
                _onPressed(context);
              },
              child: const Text("Sign in"))
        ],
      ),
    );
  }

  _onPressed(BuildContext context) {
    final String email = emailFieldController.value.text;
    final String password = passwordFieldController.value.text;
    final cubit = context.read<LandingBloc>();
    cubit.signIn(email, password);
  }
}
