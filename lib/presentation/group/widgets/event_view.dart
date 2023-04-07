import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:flutter/widgets.dart';

class EventView extends StatelessWidget {
  final Event event;

  const EventView({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Text("Event ${event.id}"),
        event is GroupExpense ? Text("Expense \$${(event as GroupExpense).getTotal()}") : Container(),
        Text("Created by ${event.createdBy.name}"),
      ]),
    );
  }
}
