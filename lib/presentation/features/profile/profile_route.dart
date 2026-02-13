import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:billsplit_flutter/presentation/features/profile/profile_page.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProfileRoute {
  static Route getRoute() {
    final widget = BlocProvider(
      create: (context) => ProfileCubit(),
      child: ProfilePage(),
    );
    return slideLeftRoute(widget);
  }
}
