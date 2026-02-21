import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PageViewTitle extends StatelessWidget {
  final PageController pageController;
  final String titleOne;
  final String titleTwo;

  const PageViewTitle({
    super.key,
    required this.pageController,
    required this.titleOne,
    required this.titleTwo,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: pageController,
      builder: (context, child) {
        final page = pageController.page ?? 0.0;

        return Container(
          constraints: const BoxConstraints(
            minHeight: 64,
            minWidth: double.infinity,
            maxHeight: 100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                onPressed: () {
                  pageController.animateToPage(
                    0,
                    duration: 500.ms,
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
                child: Text(
                  titleOne,
                  style: TextStyle(fontSize: 12 * ((page - 1).abs() + 1)),
                ),
              ),
              TextButton(
                onPressed: () {
                  pageController.animateToPage(
                    1,
                    duration: 500.ms,
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
                child: Text(titleTwo, style: TextStyle(fontSize: 12 * (page + 1))),
              ),
            ],
          ),
        );
      },
    );
  }
}
