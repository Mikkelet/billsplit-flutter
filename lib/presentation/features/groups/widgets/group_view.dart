import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/features/group/group_page.dart';
import 'package:billsplit_flutter/presentation/features/groups/bloc/groups_bloc.dart';
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
    final yourDebts = group.debtState
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(group.nameState,
                            style: Theme.of(context).textTheme.bodyLarge,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Flexible(flex: 1, child: _debtView(context, yourDebts))
                    ],
                  ),
                  const SizedBox(height: 8),
                  ProfilePictureStack(
                    people: group.people,
                    size: 30,
                    limit: 6,
                  ),
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
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: Colors.red));
    }
    if (debt < 0) {
      return Text("\$${debt.abs().fmt2dec()}",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
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
