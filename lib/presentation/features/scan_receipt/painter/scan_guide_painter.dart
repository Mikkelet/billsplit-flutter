import 'package:billsplit_flutter/domain/models/decimal_denominator.dart';
import 'package:flutter/material.dart';

class ScanGuidePainter extends CustomPainter {
  final DecimalDenominator commaDenominator;

  ScanGuidePainter(this.commaDenominator);

  @override
  void paint(Canvas canvas, Size size) {
    final verticalDivPaint = Paint();
    verticalDivPaint.color = Colors.grey;
    final offsetX = (size.width / 3) * 2;
    final offsetY = size.height / 2;
    final height = size.height - size.height / 3;
    final verticalDivBox = Rect.fromCenter(
        center: Offset(offsetX, offsetY), width: 2, height: height);
    canvas.drawRect(verticalDivBox, verticalDivPaint);

    double textHeight = 0;
    for (int i = 0; i < 10; i++) {
      final textSpan = TextSpan(
          text: "100${commaDenominator.decimal}00",
          style: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            color: Colors.grey,
          ));
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      if (textHeight == 0) textHeight = textPainter.height;
      final divHeight = height / 10;
      final padding = textHeight / 2;
      final textOffsetY = size.height / 2 - size.height / 3 + padding;
      final textOffsetX = (size.width / 5) * 4;
      textPainter.paint(canvas, Offset(textOffsetX, textOffsetY + divHeight * i));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
