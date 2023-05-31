import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PageViewTitle extends StatefulWidget {
  final PageController pageController;
  final String titleOne;
  final String titleTwo;

  const PageViewTitle(
      {Key? key,
      required this.pageController,
      required this.titleOne,
      required this.titleTwo})
      : super(key: key);

  @override
  State<PageViewTitle> createState() => _PageViewTitleState();
}

class _PageViewTitleState extends SafeState<PageViewTitle> {
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
          minHeight: 64, minWidth: double.infinity, maxHeight: 100),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
                onPressed: () {
                  widget.pageController.animateToPage(0,
                      duration: 500.ms, curve: Curves.fastEaseInToSlowEaseOut);
                },
                child: Text(widget.titleOne,
                    style: TextStyle(fontSize: 12 * ((page - 1).abs() + 1)))),
            TextButton(
                onPressed: () {
                  widget.pageController.animateToPage(1,
                      duration: 500.ms, curve: Curves.fastEaseInToSlowEaseOut);
                },
                child: Text(widget.titleTwo,
                    style: TextStyle(fontSize: 12 * (page + 1)))),
          ]),
    );
  }
}
