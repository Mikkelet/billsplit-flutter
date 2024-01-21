import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final String text;
  final int counter;
  final Function()? onClick;
  final IconData? icon;

  const ProfileListItem(
      {super.key,
      required this.text,
      this.counter = 0,
      this.onClick,
      this.icon = Icons.chevron_right});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.labelMedium,
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
                  icon,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ],
            ),
          ),
        ),
        if (true) const Divider()
      ],
    );
  }
}
