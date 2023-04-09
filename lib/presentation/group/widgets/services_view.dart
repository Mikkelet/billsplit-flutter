import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/widgets/service_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupBloc>();
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<Iterable<SubscriptionService>>(
            stream: cubit.getServicesStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }
              final data = snapshot.data!;
              if (data.isEmpty) return const Center(child: Text("No services"));
              return Column(
                children: [
                  Container(height: 80),
                  ...data.map((e) => ServiceView(e))
                ],
              );
            }),
      ),
    );
  }
}
