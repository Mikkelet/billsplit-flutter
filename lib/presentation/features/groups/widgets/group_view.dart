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
                  Text(group.nameState,
                      style: Theme.of(context).textTheme.bodyLarge,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis),
                  _debtView(context, yourDebts),
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
    final cubit = context.read<GroupsBloc>();
    final convertDebt = cubit.convertToDefault(debt);
    final String currency =
        cubit.sharedPrefs.userPrefDefaultCurrency.toUpperCase();
    if (convertDebt == 0) {
      return const SizedBox();
    }
    return Row(
      children: [
        const SizedBox(width: 64),
        const Expanded(child: SizedBox()),
        Text(
          currency,
          style:
              TextStyle(fontSize: 10, color: Theme.of(context).disabledColor),
        ),
        const SizedBox(width: 4),
        if (debt > 0)
          Text(convertDebt.fmt2dec(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.apply(color: Colors.red)),
        if (debt < 0)
          Text(convertDebt.abs().fmt2dec(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.apply(color: Colors.green))
      ],
    );
  }

  void _onClick(BuildContext context) {
    Navigator.of(context).push(GroupPage.getRoute(group));
  }
}
