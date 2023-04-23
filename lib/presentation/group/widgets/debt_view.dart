import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/dialogs/error_dialog.dart';
import 'package:billsplit_flutter/presentation/group/bloc/debt_cubit.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtView extends StatelessWidget {
  final Pair<Person, num> debt;

  const DebtView({Key? key, required this.debt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "";
    Color color = Colors.black;
    final isDebt = debt.second > 0;
    if (isDebt) {
      text = "You owe \$${debt.second.fmt2dec()} to ${debt.first.nameState}";
      color = Colors.redAccent;
    } else if (debt.second < 0) {
      text =
          "${debt.first.nameState} owes you \$${debt.second.abs().fmt2dec()}";
      color = Colors.green;
    } else {
      return const SizedBox();
    }
    final groupCubit = context.read<GroupBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupBloc>(create: (context) => groupCubit),
        BlocProvider<DebtCubit>(create: (context) => DebtCubit()),
      ],
      child: BlocListener<DebtCubit, UiState>(
        listener: (context, state) {
          if (state is Failure) {
            showDialog(
                context: context,
                builder: (context) => ErrorDialog(state.error));
          }
        },
        child: BaseBlocBuilder<DebtCubit>(builder: (debtCubit, state) {
          return RoundedListItem(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text, style: TextStyle(color: color)),
              if (isDebt && state is! Loading)
                SimpleButton(
                  onClick: () {
                    debtCubit.payDebt(groupCubit.group.id, debt);
                  },
                  child: Text(
                    "Pay",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                )
              else if (state is Loading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          ));
        }),
      ),
    );
  }
}
