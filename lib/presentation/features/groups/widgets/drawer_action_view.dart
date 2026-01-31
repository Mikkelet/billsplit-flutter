import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/features/groups/bloc/groups_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerActionView extends StatelessWidget {
  const DrawerActionView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupsBloc>();
    final scaffold = Scaffold.of(context);
    void onClick() => scaffold.openEndDrawer();

    return DefaultStreamBuilder(
        stream: cubit.notificationStream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Builder(builder: (context) {
              if (snapshot == 0) {
                return IconButton(
                  onPressed: onClick,
                  icon: const Icon(Icons.menu),
                );
              }
              return Container(
                height: 32,
                width: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: Theme.of(context).colorScheme.secondaryContainer),
                child: TextButton(
                  onPressed: onClick,
                  style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact),
                  child: Text("$snapshot"),
                ),
              );
            }),
          );
        });
  }
}
