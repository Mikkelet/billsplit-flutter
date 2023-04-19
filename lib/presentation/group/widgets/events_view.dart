import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_view.dart';

class EventsView extends StatelessWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return BlocBuilder<GroupBloc, UiState>(builder: (context, state) {
      return DefaultStreamBuilder(
          stream: cubit.getEventsStream(),
          body: (events) {
            final lsEvents = events.toList();
            if (state is SyncingGroup && lsEvents.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (lsEvents.isEmpty) return const Center(child: Text("no events"));
            return ListView.builder(
                itemCount: events.length,
                padding: const EdgeInsets.symmetric(vertical: 40),
                reverse: true,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: EventView(event: lsEvents[index]),
                    ));
          });
    });
  }
}
