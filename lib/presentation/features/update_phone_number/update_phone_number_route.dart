import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_cubit.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/update_phone_number_flow.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

abstract class UpdatePhoneNumberRoute {
  static Route getRoute({PhoneNumber? phoneNumber}) {
    final widget = BlocProvider(
      create: (context) => UpdatePhoneNumberCubit(phoneNumber),
      child: UpdatePhoneNumberFlow(),
    );

    return slideUpRoute(widget);
  }
}
