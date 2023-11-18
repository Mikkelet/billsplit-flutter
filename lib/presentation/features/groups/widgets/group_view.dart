import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/profile_picture_stack.dart';
import 'package:billsplit_flutter/presentation/features/group/group_page.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/group_debt_view.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/group_picture.dart';
import 'package:billsplit_flutter/presentation/features/groups/widgets/group_title.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:flutter/material.dart';

class GroupView extends StatelessWidget {
  final Group group;
  final num debtToGroup;
  final bool showDebt;

  const GroupView(
      {super.key,
      required this.group,
      required this.debtToGroup,
      this.showDebt = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 10,
            spreadRadius: 1,
            color: Colors.black12,
            offset: Offset(0, 8))
      ]),
      child: Center(
        child: ClickableListItem(
          color: Theme.of(context).colorScheme.primaryContainer,
          onClick: () {
            _onClick(context);
          },
          padding: EdgeInsets.zero,
          cornerRadius: 10,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  GroupPictureView(group: group),
                  GroupTitleView(group: group)
                ],
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
                          const Spacer(),
                          Expanded(
                            child: Builder(builder: (context) {
                              if (!showDebt) return const SizedBox();
                              return GroupDebtView(
                                group: group,
                                debt: debtToGroup,
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClick(BuildContext context) {
    Navigator.of(context).push(GroupPage.getRoute(group));
  }
}
