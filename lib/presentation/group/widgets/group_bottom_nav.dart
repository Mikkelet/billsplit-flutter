import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupBottomNav extends StatefulWidget {
  const GroupBottomNav({Key? key}) : super(key: key);

  @override
  State<GroupBottomNav> createState() => _GroupBottomNavState();
}

class _GroupBottomNavState extends State<GroupBottomNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Services"),
          BottomNavigationBarItem(icon: Icon(Icons.ad_units), label: "Debt"),
        ],
        onTap: (index) {
          _onItemSelected(context, index);
        });
  }

  void _onItemSelected(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
      context.read<GroupBloc>().showPage(_selectedIndex);
    });
  }
}
