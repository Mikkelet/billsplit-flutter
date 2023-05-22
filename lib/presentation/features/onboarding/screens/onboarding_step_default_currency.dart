import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/common/update_currency/update_currency_view.dart';
import 'package:billsplit_flutter/presentation/common/update_currency/update_currency_cubit.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class OnboardingStepDefaultCurrency extends StatelessWidget {
  const OnboardingStepDefaultCurrency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => UpdateCurrencyCubit(),
      child: BaseBlocBuilder<UpdateCurrencyCubit>(builder: (cubit, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            actions: [
              CloseButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    const SizedBox(height: 64),
                    const Text(
                      "What's your preferred currency?",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 64),
                    const UpdateCurrencyView(),
                    const SizedBox(height: 64),
                    SimpleButton(
                      onClick: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: const Text("I'm ready!"),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  static Route getRoute() =>
      slideLeftRoute(const OnboardingStepDefaultCurrency());
}
