import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExpenseViewPagerTitle extends StatefulWidget {
  final PageController pageController;

  const ExpenseViewPagerTitle({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<ExpenseViewPagerTitle> createState() => _ExpenseViewPagerTitleState();
}

class _ExpenseViewPagerTitleState extends State<ExpenseViewPagerTitle> {
  late double page = widget.pageController.initialPage.toDouble();

  @override
  void initState() {
    widget.pageController.addListener(() {
      setState(() {
        page = widget.pageController.page ?? 0.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          minHeight: 48, minWidth: double.infinity, maxHeight: 100),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
                onPressed: () {
                  widget.pageController.animateToPage(0,
                      duration: 100.ms, curve: Curves.bounceIn);
                },
                child: Text("Simple",
                    style: TextStyle(fontSize: 12 * ((page - 1).abs() + 1)))),
            TextButton(
                onPressed: () {
                  widget.pageController.animateToPage(1,
                      duration: 200.ms, curve: Curves.bounceIn);
                },
                child: Text("Extended",
                    style: TextStyle(fontSize: 12 * (page + 1)))),
          ]),
    );
  }
}
