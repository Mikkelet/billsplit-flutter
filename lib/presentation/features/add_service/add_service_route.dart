import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/presentation/features/add_service/add_service_page.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_bloc.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route addServiceRoute(Person user, Group group, SubscriptionService? subscriptionService) {
  return slideUpRoute(
    BlocProvider(
      create: (context) {
        final service =
            subscriptionService ?? SubscriptionService.newService(group: group, user: user);
        return AddServiceBloc(service, group);
      },
      child: AddServicePage(),
    ),
  );
}
