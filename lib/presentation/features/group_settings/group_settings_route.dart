import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/group_settings_page.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route groupSettingsRoute(Group group) {
  return slideUpRoute(
    BlocProvider(
      create: (context) => GroupSettingsCubit(group),
      child: GroupSettings(),
    ),
  );
}
