import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/features/group/group_page.dart';
import 'package:billsplit_flutter/presentation/features/groups/bloc/groups_bloc.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupView extends StatelessWidget {
  final Group group;

  const GroupView({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupsBloc>();

    return Center(
      child: ClickableListItem(
        color: Theme.of(context).colorScheme.primaryContainer,
        elevation: builder(
          () {
            if (Theme.of(context).colorScheme.brightness == Brightness.dark) {
              return 0;
            }
            return 2;
          },
        ),
        onClick: () {
          _onClick(context);
        },
        cornerRadius: 10,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(group.nameState,
                    style: Theme.of(context).textTheme.titleSmall,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfilePictureStack(
                      people: group.people,
                      size: 30,
                      limit: 3,
                    ),
                    StreamBuilder(
                        stream: cubit.getDebtsStream(group.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                                child: _debtView(
                                    context, group, snapshot.requireData));
                          }
                          return const SizedBox();
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO Consider
  Widget groupPicture() {
    return Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            )),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Image.network(
              "https://i.imgur.com/iIbMzPG.jpeg",
              fit: BoxFit.cover,
            )));
  }

  Widget _debtView(BuildContext context, Group group, num debt) {
    final cubit = context.read<GroupsBloc>();
    final convertDebt = cubit.convertToDefault(group, debt);
    final String currency = group.defaultCurrencyState.toUpperCase();
    if (convertDebt == 0) {
      return const SizedBox();
    }
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        if (debt > 0)
          Expanded(
            child: Text(convertDebt.fmt2dec(),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: SplitsbyTextTheme.groupViewNegativeDebt(context)),
          ),
        if (debt < 0)
          Expanded(
            child: Text(convertDebt.abs().fmt2dec(),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: SplitsbyTextTheme.groupViewPositiveDebt(context)),
          ),
        const SizedBox(width: 4),
        Text(
          currency,
          style: SplitsbyTextTheme.groupViewDebtCurrency(context),
        )
      ],
    );
  }

  void _onClick(BuildContext context) {
    Navigator.of(context).push(GroupPage.getRoute(group));
  }
}
