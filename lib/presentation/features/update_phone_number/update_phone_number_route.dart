import 'package:billsplit_flutter/presentation/features/update_phone_number/bloc/update_phone_number_cubit.dart';
import 'package:billsplit_flutter/presentation/features/update_phone_number/update_phone_number_flow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/update_phone_number/update_phone_number_route.g.dart';

@TypedGoRoute<UpdatePhoneNumberRoute>(path: '/update-phone-number')
class UpdatePhoneNumberRoute extends GoRouteData with $UpdatePhoneNumberRoute {
  final String? phoneNumber;
  const UpdatePhoneNumberRoute({this.phoneNumber});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => UpdatePhoneNumberCubit(phoneNumber),
      child: UpdatePhoneNumberFlow(),
    );
  }
}
