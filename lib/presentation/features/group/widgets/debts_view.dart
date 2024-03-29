import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/debt_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtsView extends StatelessWidget {
  const DebtsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return DefaultStreamBuilder(
      stream: cubit.getDebtsStream(),
      builder: (_, debts) {
        if (debts.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(64.0),
              child: Text(
                "All debts are settled!",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: debts.length,
          padding: const EdgeInsets.symmetric(vertical: 40),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: DebtView(debt: debts.toList()[index]),
          ),
        );
      },
    );
  }
}
