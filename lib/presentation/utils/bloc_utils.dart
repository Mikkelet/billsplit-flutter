import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocUtils on BuildContext {
  ProfileCubit get profile => read<ProfileCubit>();

  Person get user => profile.user;

  SharedPrefs get prefs => read<SharedPrefs>();
}
