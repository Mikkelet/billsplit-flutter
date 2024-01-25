import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/bloc/onboarding_state.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();

  static Route getRoute() => slideUpRoute(const OnboardingFlow());
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<OnboardingBloc>(
      create: (context) => OnboardingBloc(_controller),
      listener: (context, cubit, event) {
        if (event is NextStepEvent) {
          _onNextStepEvent(context);
        } else if (event is PreviousStepEvent) {
          _onPrevStepEvent(context);
        } else if (event is ImReadyEvent) {
          _onImReadyEvent(context);
        } else if (event is SubmitUserSuccessEvent) {
          _onSubmitSuccess(context);
        }
      },
      child: BaseBlocBuilder<OnboardingBloc>(
        builder: (cubit, state) {
          return BaseScaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: BackButton(
                onPressed: () {
                  cubit.onPreviousClicked();
                },
              ),
              actions: [
                CloseButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            body: Builder(builder: (context) {
              if (state is Loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return PageView(
                controller: _controller,
                onPageChanged: (page) {
                  cubit.onPageChanged(page);
                },
                children: cubit.steps,
              );
            }),
          );
        },
      ),
    );
  }

  void _onNextStepEvent(BuildContext context) {}

  void _onPrevStepEvent(BuildContext context) {}

  void _onImReadyEvent(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSubmitSuccess(BuildContext context) {
    Navigator.of(context).pop();
  }
}
