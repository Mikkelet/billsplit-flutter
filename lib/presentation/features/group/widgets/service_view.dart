import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/add_service/add_service_page.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
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
        Navigator.of(context)
            .push(AddServicePage.getRoute(cubit.user, cubit.group, service));
      },
      child: Row(
        children: [
          MutableValue(
            mutableValue: service.payerState,
            builder: (context, payer) {
              return ProfilePictureView(
                person: payer,
                size: 64,
              );
            }
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MutableText(
                  mutString: service.nameState,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                MutableValue(
                  mutableValue: service.currencyState,
                  builder: (context, currency) {
                    return MutableValue(
                      mutableValue: service.payerState,
                      builder: (context, payer) {
                        return MutableValue(
                          mutableValue: service.monthlyExpenseState,
                          builder: (context, monthlyService) {
                            return MutableValue(
                              mutableValue: payer.nameState,
                              builder: (context, payerName) {
                                return Text(
                                  "${currency.toUpperCase()} $monthlyService is paid by $payerName",
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                );
                              }
                            );
                          }
                        );
                      }
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
