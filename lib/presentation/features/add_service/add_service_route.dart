import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/features/add_service/add_service_page.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../../../_generated/presentation/features/add_service/add_service_route.g.dart';

@TypedGoRoute<AddServiceRoute>(path: '/groups/:groupId/service/:serviceId')
class AddServiceRoute extends GoRouteData with $AddServiceRoute {
  final String groupId;
  final String serviceId;

  const AddServiceRoute(this.groupId, this.serviceId);

  const AddServiceRoute.add(this.groupId) : serviceId = "";

  factory AddServiceRoute.edit(String groupId, String serviceId) =>
      AddServiceRoute(groupId, serviceId);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => AddServiceBloc(
        getIt.get(),
        groupId: groupId,
        serviceId: serviceId,
      ),
      child: AddServicePage(),
    );
  }
}
