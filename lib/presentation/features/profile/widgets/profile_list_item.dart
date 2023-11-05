import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final String text;
  final Function onClick;

  const ProfileListItem({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ClickableListItem(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      onClick: () => onClick(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Icon(
            Icons.arrow_right,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          )
        ],
      ),
    );
  }
}
