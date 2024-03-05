import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:flutter/material.dart';

class GroupTitleView extends StatelessWidget {
  final Group group;

  const GroupTitleView({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final BoxDecoration deco =
        BoxDecoration(color: Colors.black.withOpacity(0.5));
    const textColor = Colors.white;
    const padding = EdgeInsets.only(left: 8);
    return Container(
      constraints: const BoxConstraints(minHeight: 32),
      decoration: deco,
      alignment: Alignment.centerLeft,
      padding: padding,
      child: Text(group.nameState.value,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: textColor),
          softWrap: false,
          overflow: TextOverflow.ellipsis),
    );
  }
}
