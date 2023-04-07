import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/presentation/group/widgets/service_view.dart';
import 'package:flutter/widgets.dart';

class ServicesView extends StatelessWidget {
  final List<SubscriptionService> services;
  const ServicesView({Key? key, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...services.map((e) => ServiceView(e))
      ],
    );
  }
}
