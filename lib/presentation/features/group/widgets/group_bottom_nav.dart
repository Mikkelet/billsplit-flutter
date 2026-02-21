import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupBottomNav extends StatelessWidget {
  const GroupBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    const destinations = [
      NavigationDestination(icon: Icon(Icons.receipt_outlined), label: "Expenses"),
      NavigationDestination(icon: Icon(Icons.update_outlined), label: "Subscriptions"),
      NavigationDestination(icon: Icon(Icons.monetization_on_outlined), label: "Debts"),
    ];

    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        final navIndex = state.groupNav.index;

        return NavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          indicatorColor: Theme.of(context).colorScheme.tertiary,
          selectedIndex: navIndex > destinations.length - 1 ? 0 : navIndex,
          destinations: destinations,
          onDestinationSelected: (index) {
            if (index == navIndex) return;
            final cubit = context.read<GroupBloc>();
            cubit.showPage(GroupPageNav.fromIndex(index));
          },
        );
      },
    );
  }
}
