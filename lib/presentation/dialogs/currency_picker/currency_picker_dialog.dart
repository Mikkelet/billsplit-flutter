import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:flutter/material.dart';

import 'currency_picker_cubit.dart';

class CurrencyPickerDialog extends StatelessWidget {
  const CurrencyPickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BaseBlocWidget(
        create: (context) => CurrencyPickerCubit(),
        child: BaseBlocBuilder<CurrencyPickerCubit>(builder: (cubit, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: cubit.currencies.map((currency) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(currency);
                          },
                          style: const ButtonStyle(
                              alignment: Alignment.centerLeft),
                          child: Text(
                            currency.symbol.toUpperCase(),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        }),
      ),
    );
  }
}
