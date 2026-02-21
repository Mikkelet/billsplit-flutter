import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/presentation/features/add_service/add_service_page.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_bloc.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
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
      create: (context) => AddServiceBloc(groupId, serviceId),
      child: AddServicePage(),
    );
  }
}
