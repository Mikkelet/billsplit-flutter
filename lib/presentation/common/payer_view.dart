import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:flutter/material.dart';

class PayerView extends StatelessWidget {
  final Person person;
  final bool isPayer;
  final double size;
  final Function() onClick;

  const PayerView(
      {Key? key,
      required this.person,
      required this.isPayer,
      required this.onClick,
      this.size = 64})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            iconSize: size,
            onPressed: onClick,
            padding: EdgeInsets.zero,
            icon: ProfilePictureView(person: person, size: size),
          ),
          if (isPayer)
            CircleAvatar(
              backgroundColor: Colors.black54,
              child: Icon(
                color: Colors.greenAccent,
                Icons.credit_score_rounded,
                size: size * 0.5,
              ),
            )
        ],
      ),
    );
  }
}
