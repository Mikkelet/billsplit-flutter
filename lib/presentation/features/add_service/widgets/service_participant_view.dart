import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_bloc.dart';
import 'package:billsplit_flutter/presentation/common/payer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceParticipantView extends StatelessWidget {
  final Person person;

  const ServiceParticipantView({Key? key, required this.person})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddServiceBloc>();
    final isPayer = cubit.service.payerState.uid == person.uid;

    return Row(
      children: [
        PayerView(
            person: person,
            size: 40,
            isPayer: isPayer,
            onClick: () {
              cubit.onPayerClicked(person);
            }),
        const SizedBox(width: 4),
        if (isPayer)
          Expanded(
            child: TextButton(
              style: const ButtonStyle(
                alignment: Alignment.centerLeft
              ),
              onPressed: () {},
              child: Text(
                "${person.displayName} is paying",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          )
        else
          Expanded(
            child: TextButton(
                style: const ButtonStyle(
                    alignment: Alignment.centerLeft
                ),
                onPressed: () {
                  cubit.onPayerClicked(person);
                },
                child: Text(
                  person.displayName,
                  style: Theme.of(context).textTheme.labelSmall,
                )),
          ),
      ],
    );
  }
}
