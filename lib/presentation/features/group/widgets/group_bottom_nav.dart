import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupBottomNav extends StatefulWidget {
  const GroupBottomNav({Key? key}) : super(key: key);

  @override
  State<GroupBottomNav> createState() => _GroupBottomNavState();
}

class _GroupBottomNavState extends State<GroupBottomNav> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, UiState>(builder: (context, state) {
      if (state is GroupLoaded) {
        if (state.nav.index != navIndex) {
          navIndex = state.nav.index;
        }
      }
      const destinations = [
        NavigationDestination(icon: Icon(Icons.receipt_outlined), label: "Expenses"),
        NavigationDestination(icon: Icon(Icons.update_outlined), label: "Services"),
        NavigationDestination(icon: Icon(Icons.monetization_on_outlined), label: "Debts")
      ];
      return NavigationBar(
        selectedIndex: navIndex > destinations.length - 1 ? 0 : navIndex,
        destinations: destinations,
        onDestinationSelected: (index) {
          _onItemSelected(context, index);
        },
      );
    });
  }

  void _onItemSelected(BuildContext context, int index) {
    if (index == navIndex) return;
    final cubit = context.read<GroupBloc>();
    cubit.showPage(GroupPageNav.fromIndex(index));
  }
}
