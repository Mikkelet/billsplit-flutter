import 'package:billsplit_flutter/presentation/features/group_invites/bloc/group_invite_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group_invites/group_invites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final groupInvitesRoute = MaterialPageRoute(
  builder: (context) {
    return BlocProvider(
      create: (context) => GroupInvitesCubit(),
      child: GroupInvitesPage(),
    );
  },
);
