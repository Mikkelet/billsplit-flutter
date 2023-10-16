import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/features/group/group_page.dart';
import 'package:billsplit_flutter/presentation/features/groups/bloc/groups_bloc.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        elevation: _getElevation(context),
        onClick: () {
          _onClick(context);
        },
        padding: EdgeInsets.zero,
        cornerRadius: 10,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [_groupPicture(), _getGroupTitle(context)],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfilePictureStack(
                          people: group.people,
                          size: 30,
                          limit: 3,
                        ),
                        StreamBuilder(
                            stream: cubit.getDebtsStream(group),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Expanded(
                                  child:
                                      _debtView(context, snapshot.requireData),
                                );
                              }
                              return const SizedBox();
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _groupPicture() {
    if (group.coverImageUrlState.isEmpty) {
      return Container(
        decoration: const BoxDecoration(color: Colors.white),
      );
    }
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: CachedNetworkImage(
          imageUrl: group.coverImageUrlState,
          fadeInDuration: Duration.zero,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _getGroupTitle(BuildContext context) {
    final BoxDecoration? deco = group.coverImageUrlState.isNotEmpty
        ? BoxDecoration(color: Colors.black.withOpacity(0.5))
        : null;
    final textColor = group.coverImageUrlState.isEmpty
        ? Theme.of(context).colorScheme.onBackground
        : Colors.white;
    final padding = group.coverImageUrlState.isEmpty
        ? const EdgeInsets.all(8)
        : const EdgeInsets.only(left: 8);
    return Container(
      constraints: const BoxConstraints(minHeight: 32),
      decoration: deco,
      alignment: Alignment.centerLeft,
      padding: padding,
      child: Text(group.nameState,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: textColor),
          softWrap: false,
          overflow: TextOverflow.ellipsis),
    );
  }

  Widget _debtView(BuildContext context, num debt) {
    final String currency = group.defaultCurrencyState.toUpperCase();
    if (debt == 0) {
      return const SizedBox();
    }
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        if (debt > 0)
          Expanded(
            child: Text(debt.fmt2dec(),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: SplitsbyTextTheme.groupViewNegativeDebt(context)),
          ),
        if (debt < 0)
          Expanded(
            child: Text(debt.abs().fmt2dec(),
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

  double _getElevation(BuildContext context) {
    if (Theme.of(context).colorScheme.brightness == Brightness.dark) {
      return 0;
    }
    return 2;
  }
}
