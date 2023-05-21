import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/default_currency/default_group_currency_cubit.dart';
import 'package:flutter/material.dart';

class DefaultGroupCurrencyView extends StatelessWidget {
  final Group group;

  const DefaultGroupCurrencyView({Key? key, required this.group})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => DefaultGroupCurrencyCubit(group),
      child: BaseBlocBuilder<DefaultGroupCurrencyCubit>(
        builder: (cubit, state) {
          return RoundedListItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cubit.group.defaultCurrencyState.toUpperCase(),
                ),
                if (state is Loading)
                  const CircularProgressIndicator()
                else
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final response = await Navigator.of(context).push(
                              CurrencyPickerDialog.getRoute(
                                  convertToCurrency:
                                      cubit.group.defaultCurrencyState));
                          if (response is Currency) {
                            cubit.updateCurrency(response);
                          }
                        }),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
