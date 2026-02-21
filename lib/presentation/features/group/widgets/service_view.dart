import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/add_service/add_service_route.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceView extends StatelessWidget {
  final SubscriptionService service;

  const ServiceView(this.service, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return ClickableListItem(
      onClick: () {
        AddServiceRoute.edit(cubit.state.requireGroup.id, service.id);
      },
      child: Row(
        children: [
          ProfilePictureView(
            person: service.payer,
            size: 64,
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  service.name,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Builder(
                  builder: (context) {
                    final currency = service.currency;
                    final payer = service.payer;
                    final payerName = payer.name;
                    return Text(
                      "${currency.toUpperCase()} ${service.monthlyExpense} is paid by $payerName",
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
