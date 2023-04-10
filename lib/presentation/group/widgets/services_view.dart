import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/widgets/service_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return DefaultStreamBuilder(
      stream: cubit.getServicesStream(),
      noData: const Padding(
        padding: EdgeInsets.all(64.0),
        child: Text(
          "Subscription service expenses will be automatically added each month! Use this for monthly expenses like rent, streaming service, co-budget, etc",
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: (services) {
        return ListView.builder(
            itemCount: services.length,
            padding: const EdgeInsets.symmetric(vertical: 40),
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ServiceView(services.toList()[index]),
                ));
      },
    );
  }
}
