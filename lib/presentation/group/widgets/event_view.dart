import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/widgets/events/expense_event_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventView extends StatelessWidget {
  final Event event;

  const EventView({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    final isCreatedByUser = event.createdBy.uid == cubit.user.uid;
    return Builder(builder: (context) {
      if (event is GroupExpense) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            isCreatedByUser
                ? const SizedBox()
                : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ProfilePictureView(person: event.createdBy),
                ),
            Flexible(
              child: ExpenseEventView(groupExpense: event as GroupExpense),
            ),
            isCreatedByUser
                ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ProfilePictureView(person: event.createdBy),
                )
                : const SizedBox(),
          ],
        );
      }
      return Container();
    });
  }
}
