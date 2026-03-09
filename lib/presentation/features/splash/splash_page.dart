import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/features/groups/groups_route.dart';
import 'package:billsplit_flutter/presentation/features/splash/bloc/splash_cubit.dart';
import 'package:billsplit_flutter/presentation/features/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (prev, curr) => !curr.isLoading,
      listener: (context, state) {
        GroupsRoute().go(context);
      },
      child: BaseScaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: const Center(
          child: ClipOval(
            child: Image(
              height: 200,
              width: 200,
              image: AssetImage('assets/splitsby_logo.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
