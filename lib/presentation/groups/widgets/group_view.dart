import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/group/group_page.dart';
import 'package:billsplit_flutter/presentation/groups/bloc/groups_bloc.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupView extends StatelessWidget {
  final Group group;

  const GroupView({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupsBloc>();
    final yourDebts = group.debts
            .where((element) => element.userId == cubit.user.uid)
            .firstOrNull
            ?.owes ??
        0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      child: Center(
        child: ClickableListItem(
          onClick: () {
            _onClick(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(group.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                      ),
                      _debtView(context, yourDebts)
                    ],
                  ),
                  Row(
                    children: [
                      ...group.people.map((e) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ProfilePictureView(person: e, size: 30,),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _debtView(BuildContext context, num debt) {
    if (debt > 0) {
      return Text("\$${debt.fmt2dec()}",
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: Colors.red));
    }
    if (debt < 0) {
      return Text("\$${debt.abs().fmt2dec()}",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.apply(color: Colors.green));
    }
    return const SizedBox();
  }

  void _onClick(BuildContext context) {
    Navigator.of(context).push(GroupPage.getRoute(group));
  }
}
