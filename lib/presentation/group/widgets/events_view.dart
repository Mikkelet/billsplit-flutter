import 'package:billsplit_flutter/extentions.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/models/event.dart';
import 'event_view.dart';

class EventsView extends StatelessWidget {
  final List<Event> events;

  const EventsView({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ...events.mapToImmutableList((event) => EventView(event: event))
        ],
      ),
    );
  }
}
