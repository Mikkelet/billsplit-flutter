import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/developer_settings/developer_settings_cubit.dart';
import 'package:flutter/material.dart';

class DeveloperSettingsPage extends StatelessWidget {
  const DeveloperSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => DeveloperSettingsCubit(),
      child: BaseBlocBuilder<DeveloperSettingsCubit>(
        builder: (cubit, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                const SizedBox(height: 32),
                ClickableListItem(
                    onClick: () {
                      cubit.resetGuides();
                      cubit.showToast("Guides reset");
                    },
                    child: const Text("Reset guides")),
              ],
            ),
          );
        },
      ),
    );
  }

  static Route getRoute() => MaterialPageRoute(builder: (context)=>const DeveloperSettingsPage());
}
