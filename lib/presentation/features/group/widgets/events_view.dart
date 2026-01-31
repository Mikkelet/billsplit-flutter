import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/events/expense_event_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_view.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return BlocBuilder<GroupBloc, UiState>(builder: (context, state) {
      return DefaultStreamBuilder(
          loaderWidget: const SizedBox(),
          stream: cubit.getEventsStream(),
          builder: (_, events) {
            if (events.isEmpty) {
              return Center(
                  child: Text(
                "Click below to add a new expense!",
                style: Theme.of(context).textTheme.labelLarge,
              ));
            }
            return ListView.builder(
                itemCount: events.length,
                padding: const EdgeInsets.symmetric(vertical: 40),
                reverse: true,
                itemBuilder: (context, index) {
                  final event = events[index];
                  final isLatestIndex = _isLatestIndex(index, event, events);
                  final shouldShowProfilePictureLeft =
                      event.createdBy.uid != cubit.user.uid &&
                          event is! Payment;
                  final shouldShowProfilePictureRight =
                      event.createdBy.uid == cubit.user.uid &&
                          event is! Payment;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Builder(builder: (context) {
                      if (event is GroupExpense) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (shouldShowProfilePictureLeft)
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: _createdByProfilePicture(
                                    event.createdBy, isLatestIndex),
                              ),
                            Flexible(
                                child: ExpenseEventView(groupExpense: event)),
                            if (shouldShowProfilePictureRight)
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: _createdByProfilePicture(
                                    event.createdBy, isLatestIndex),
                              ),
                          ],
                        );
                      }
                      return EventView(event: event);
                    }),
                  );
                });
          });
    });
  }

  Widget _createdByProfilePicture(Person person, bool isLatestIndex) {
    if (isLatestIndex) {
      return ProfilePictureView(person: person, canInspect: true);
    } else {
      return const SizedBox(
        height: 40,
        width: 40,
      );
    }
  }

  bool _isLatestIndex(int index, Event event, List<Event> events) {
    try {
      return events[index - 1].createdBy.uid != event.createdBy.uid ||
          events[index - 1] is Payment;
    } catch (e) {
      return true;
    }
  }
}
