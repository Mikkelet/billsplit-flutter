import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/events/expense_event_view.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/events/payment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventView extends StatelessWidget {
  final Event event;

  const EventView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    final isCreatedByUser = event.createdBy.uid == cubit.user.uid;
    return Builder(builder: (context) {
      if (event is GroupExpense) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isCreatedByUser)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ProfilePictureView(
                    person: event.createdBy, canInspect: true),
              ),
            Flexible(
              child: ExpenseEventView(groupExpense: event as GroupExpense),
            ),
            if (isCreatedByUser)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ProfilePictureView(person: event.createdBy),
              )
          ],
        );
      }
      if (event is Payment) {
        return PaymentView(payment: event as Payment);
      }
      return const SizedBox();
    });
  }
}
