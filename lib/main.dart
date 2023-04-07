import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/presentation/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/add_expense/widgets/individual_expense_view.dart';
import 'package:billsplit_flutter/presentation/group/group_page.dart';
import 'package:billsplit_flutter/presentation/groups/groups_page.dart';
import 'package:billsplit_flutter/presentation/main_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/models/Person.dart';

void main() {
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
    return BlocProvider(
      create: (context) => MainNavCubit()..showGroups(),
      child: MaterialApp(
        title: 'Splitsby',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const GroupsPage(),
          "add_expense": (context) => const AddExpensePage(),
          "group": (context) => const GroupPage(),
          NavRoute.loading.name: (context) =>
              const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class SplitsbyApp extends StatelessWidget {
  const SplitsbyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainNavCubit()..showGroups(),
      child: Scaffold(
        body: BlocBuilder<MainNavCubit, MainNavState>(
          builder: (context, state) {
            late final Widget widget;
            switch (state.runtimeType) {
              case ShowLoading:
                widget = const Center(child: CircularProgressIndicator());
                break;
              case ShowGroups:
                widget = const GroupsPage();
                break;
              case ShowGroup:
                widget = const GroupPage();
                break;
              default:
                widget = const Placeholder();
                break;
            }
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                      opacity: animation,
                      child: Container(
                          key: ValueKey(state.hashCode), child: child));
                },
                child: widget);
          },
        ),
      ),
    );
  }
}
