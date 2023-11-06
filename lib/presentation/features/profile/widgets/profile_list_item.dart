import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final String text;
  final int counter;
  final Function onClick;

  const ProfileListItem(
      {super.key, required this.text, this.counter = 0, required this.onClick});

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
          const Spacer(),
          if (counter > 0)
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(90),
              ),
              alignment: Alignment.center,
              child: Text("$counter"),
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
