import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/groups/groups_page.dart';
import 'package:billsplit_flutter/presentation/landing/landing_page.dart';
import 'package:billsplit_flutter/presentation/main_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

enum NavRoute {
  groups,
  group,
  loading,
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splitsby',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: BlocProvider(
        create: (context) => MainCubit()..initialize(),
        child: BlocBuilder<MainCubit, UiState>(builder: (context, state) {
          if (state is Loading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is Failure) {
            return Scaffold(body: Center(child: Text(state.error.toString())));
          }
          if(state is Main) {
            final cubit = context.read<MainCubit>();
            return StreamBuilder<String?>(
              stream: cubit.observeAuthState(),
              builder: (context, snapshot) {
                final uid = snapshot.data;
                if (uid == null) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  return const LandingPage();
                }
                return const GroupsPage();
              });
          }
          return const Placeholder();
        }),
      ),
    );
  }
}
