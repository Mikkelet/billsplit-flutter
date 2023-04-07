import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:billsplit_flutter/presentation/group/widgets/events_view.dart';
import 'package:billsplit_flutter/presentation/group/widgets/group_bottom_nav.dart';
import 'package:billsplit_flutter/presentation/group/widgets/services_view.dart';
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            _onFabClicked(context);
          },
        ),
        bottomNavigationBar: const GroupBottomNav(),
        body: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GroupLoaded) {
              Widget widget;
              switch (state.nav) {
                case GroupPageNav.services:
                  widget = ServicesView(services: state.services);
                  break;
                case GroupPageNav.debt:
                  widget = const Placeholder();
                  break;
                default:
                  widget = EventsView(events: state.events);
                  break;
              }
              return WillPopScope(
                  child: widget,
                  onWillPop: () async {
                    if (state.nav != GroupPageNav.events) {
                      context.read<GroupBloc>().showEvents();
                      return false;
                    }
                    return true;
                  });
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }

  _onFabClicked(BuildContext context) {
    Navigator.of(context).pushNamed("add_expense");
  }

  static String route = "group";
}
