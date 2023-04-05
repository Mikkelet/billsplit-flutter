import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:billsplit_flutter/presentation/group/widgets/events_view.dart';
import 'package:billsplit_flutter/presentation/group/widgets/group_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final argGroupId = args["group_id"] ?? "";
    return BlocProvider(
      create: (context) => GroupBloc()..loadGroup(argGroupId),
      child: Scaffold(
        bottomNavigationBar: const GroupBottomNav(),
        body: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GroupLoaded) {
              switch (state.navIndex) {
                case 1:
                case 2:
                  return const Placeholder();
                default:
                  return EventsView(events: state.events);
              }
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }

  static String route = "group";
}
