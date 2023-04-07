import 'package:billsplit_flutter/presentation/landing/bloc/landing_bloc.dart';
import 'package:billsplit_flutter/presentation/landing/widgets/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LandingBloc(),
        child: SignInView(),
      ),
    );
  }
}
