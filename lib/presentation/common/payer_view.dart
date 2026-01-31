import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:flutter/material.dart';

class PayerView extends StatelessWidget {
  final Person person;
  final double size;
  final Function() onClick;

  const PayerView({
    super.key,
    required this.person,
    required this.onClick,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: size,
      visualDensity: VisualDensity.compact,
      onPressed: onClick,
      padding: EdgeInsets.zero,
      icon: ProfilePictureView(person: person, size: size),
    );
  }
}
