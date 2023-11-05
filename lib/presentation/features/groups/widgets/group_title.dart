import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:flutter/material.dart';

class GroupTitleView extends StatelessWidget {
  final Group group;
  const GroupTitleView({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
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
}
