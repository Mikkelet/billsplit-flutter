import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/groups/groups_page.dart';
import 'package:billsplit_flutter/presentation/landing/landing_page.dart';
import 'package:billsplit_flutter/presentation/main_nav_cubit.dart';
import 'package:flutter/material.dart';

import 'presentation/common/base_bloc_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
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
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData(
        splashFactory: InkSplash.splashFactory,
        useMaterial3: true,
      ),
      home: BaseBlocWidget(
        create: (context) => MainCubit()..initialize(),
        child: BaseBlocBuilder<MainCubit>(
          builder: (cubit, state) {
            if (state is Loading) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }
            if (state is Main) {
              return StreamBuilder<String?>(
                stream: cubit.observeAuthState(),
                builder: (context, snapshot) {
                  final uid = snapshot.data;
                  if (uid == null) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    return const LandingPage();
                  }
                  return const GroupsPage();
                },
              );
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
