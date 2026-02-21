import 'package:billsplit_flutter/presentation/features/inspect_profile/bloc/inspect_profile_cubit.dart';
import 'package:billsplit_flutter/presentation/features/inspect_profile/inspect_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/person.dart';

Route<dynamic> inspectProfileRoute(Person person) => MaterialPageRoute(
  builder: (context) {
    return BlocProvider(
      create: (context) => InspectProfileCubit(person),
      child: InspectProfilePage(),
    );
  },
);

