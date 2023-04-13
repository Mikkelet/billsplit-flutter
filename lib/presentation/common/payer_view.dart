import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:flutter/material.dart';

class PayerView extends StatelessWidget {
  final Person person;
  final bool isPayer;
  final Function() onClick;

  const PayerView(
      {Key? key,
      required this.person,
      required this.isPayer,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                  child: Image.network(
                person.pfpUrl,
                height: 80,
                width: 80,
                fit: BoxFit.fitWidth,
              )),
              isPayer
                  ? const Icon(
                      color: Colors.greenAccent,
                      Icons.attach_money_rounded,
                      size: 40,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
