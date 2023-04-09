import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_view.dart';

class EventsView extends StatelessWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder(
            stream: cubit.getEventsStream(),
            builder: (context, snapshot) {
              print("qqq hasData=${snapshot.hasData}, snapshot=$snapshot, ");
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }
              final data = snapshot.data!;
              if (data.isEmpty) return const Center(child: Text("No events"));
              return Column(
                children: [
                  Container(
                    height: 80,
                  ),
                  Text("group: ${cubit.group.id}"),
                  ...data.map((event) => EventView(event: event))
                ],
              );
            }),
      ),
    );
  }
}
