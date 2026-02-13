import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/features/groups/groups_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/groups_bloc.dart';

  final groupsRoute = BlocProvider(
  create: (context) => GroupsBloc(getIt.get()),
  child: GroupsPage(),
);
