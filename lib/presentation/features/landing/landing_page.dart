import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/features/landing/bloc/landing_state.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/sign_in_view.dart';
import 'package:billsplit_flutter/presentation/features/landing/widgets/sign_up_view.dart';
import 'package:flutter/material.dart';

import 'bloc/landing_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseBlocWidget(
        create: (context) => LandingBloc(),
        child: BaseBlocBuilder<LandingBloc>(
          builder: (cubit, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ShowSignUp) {
              return const SignUpView();
            }
            return const SignInView();
          },
        ),
      ),
    );
  }
}
