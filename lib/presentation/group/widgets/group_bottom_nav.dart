import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupBottomNav extends StatefulWidget {
  const GroupBottomNav({Key? key}) : super(key: key);

  @override
  State<GroupBottomNav> createState() => _GroupBottomNavState();
}

class _GroupBottomNavState extends State<GroupBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, UiState>(builder: (context, state) {
      int navIndex = 0;
      if(state is GroupLoaded){
        navIndex = state.nav.index;
      }
      return BottomNavigationBar(
            currentIndex: navIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Events"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.ac_unit), label: "Services"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.ad_units), label: "Debt"),
            ],
            onTap: (index) {
              _onItemSelected(context, index);
            });
    });
  }

  void _onItemSelected(BuildContext context, int index) {
    final cubit = context.read<GroupBloc>();
    cubit.showPage(GroupPageNav.fromIndex(index));
  }
}
