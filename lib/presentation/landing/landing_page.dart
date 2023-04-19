import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/landing/bloc/landing_bloc.dart';
import 'package:billsplit_flutter/presentation/landing/widgets/sign_in_view.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseBlocWidget(
        create: (context) => LandingBloc(),
        child: SignInView(),
      ),
    );
  }
}
