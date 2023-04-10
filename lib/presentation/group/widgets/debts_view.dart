import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/widgets/debt_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtsView extends StatelessWidget {
  const DebtsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return DefaultStreamBuilder(
        stream: cubit.getDebtsStream(),
        noData: const Padding(
          padding: EdgeInsets.all(64.0),
          child: Text(
            "All debts are settled!",
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        listItem: (debt) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: DebtView(debt: debt),
        ));
  }
}
