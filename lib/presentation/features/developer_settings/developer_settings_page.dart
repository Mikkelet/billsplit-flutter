import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/developer_settings/developer_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/features/onboarding/onboarding_flow.dart';
import 'package:billsplit_flutter/presentation/features/permissions/notification_rationale_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeveloperSettingsPage extends StatelessWidget {
  const DeveloperSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeveloperSettingsCubit(getIt.get()),
      child: BlocBuilder<DeveloperSettingsCubit, int>(
        builder: (context, state) {
          final cubit = context.read<DeveloperSettingsCubit>();
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                const SizedBox(height: 32),
                ClickableListItem(
                  onClick: () {
                    cubit.resetGuides();
                  },
                  child: const Text("Reset guides"),
                ),
                const SizedBox(height: 32),
                ClickableListItem(
                  onClick: () {
                    Navigator.of(context).push(OnboardingFlow.getRoute());
                  },
                  child: const Text("Start onboarding"),
                ),
                const SizedBox(height: 32),
                ClickableListItem(
                  onClick: () {
                    NotificationRationaleRoute().push(context);
                  },
                  child: const Text("Start Rationale"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Route getRoute() => MaterialPageRoute(builder: (context) => const DeveloperSettingsPage());
}
