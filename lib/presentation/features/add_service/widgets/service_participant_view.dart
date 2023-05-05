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
        Flexible(
          child: PayerView(
              person: person,
              isPayer: isPayer,
              onClick: () {
                cubit.onPayerClicked(person);
              }),
        ),
        const SizedBox(width: 8),
        if (isPayer)
          Text("${person.nameState} is paying")
        else
          Text(person.nameState),
      ],
    );
  }
}
