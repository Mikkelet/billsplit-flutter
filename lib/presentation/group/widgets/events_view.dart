import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/event.dart';
import 'event_view.dart';

class EventsView extends StatelessWidget {
  final List<Event> events;

  const EventsView({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>().state as GroupLoaded;
    return Center(
      child: SingleChildScrollView(
        child: Builder(builder: (context) {
          if (events.isEmpty) return const Center(child: Text("No events"));
          return Column(
            children: [
              Container(
                height: 80,
              ),
              Text("group: ${cubit.group.id}"),
              ...events.mapToImmutableList((event) => EventView(event: event))
            ],
          );
        }),
      ),
    );
  }
}
