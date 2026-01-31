import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortActionButton extends StatelessWidget {
  const SortActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return IconButton(
      onPressed: () async {
        const rect = Rect.fromLTRB(double.infinity, 0, 0, 0);
        final response = await showMenu(
            context: context,
            position: RelativeRect.fromSize(rect, Size.zero),
            items: <PopupMenuItem>[
              PopupMenuItem(
                value: SortEvents.added,
                enabled: cubit.sortedBy != SortEvents.added,
                child: const Text("Sort chronologically"),
              ),
              PopupMenuItem(
                  value: SortEvents.specified,
                  enabled: cubit.sortedBy != SortEvents.specified,
                  child: const Text("Sort by date submitted")),
            ]);
        if (response is SortEvents) {
          cubit.changeSort(response);
        }
      },
      icon: const Icon(Icons.sort),
    );
  }
}
