import 'package:billsplit_flutter/domain/use_cases/scan_receipt_usecase.dart';
import 'package:flutter/material.dart';

class TextBlockPainter extends CustomPainter {
  final ScannedReceipt scannedReceipt;
  final double upperBarrier;
  final double lowerBarrier;

  TextBlockPainter(this.scannedReceipt, this.upperBarrier, this.lowerBarrier);

  @override
  void paint(Canvas canvas, Size size) {
    bool even = false;

    for (var text in scannedReceipt.items) {
      final bbox = text.boundaryBox;

      // check if *outside* barriers
      if (bbox.top < upperBarrier) continue;
      if (bbox.bottom > lowerBarrier) continue;

      final paint = Paint();
      paint.style = PaintingStyle.stroke;
      paint.color = even ? Colors.green : Colors.blue;
      even = !even;
      paint.strokeWidth = 2;
      canvas.drawRect(bbox, paint);
    }

    final barrierPaint = Paint()..color = Colors.black.withAlpha(200);
    final barrierDragLimitPain = Paint()..color = Colors.green;

    barrierPaint.style = PaintingStyle.fill;
    barrierPaint.strokeWidth = 2;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, upperBarrier), barrierPaint);
    canvas.drawRect(Rect.fromLTWH(0, upperBarrier - 10, size.width, 10),
        barrierDragLimitPain);

    canvas.drawRect(
        Rect.fromLTWH(
            0, lowerBarrier, size.width, canvas.getLocalClipBounds().height),
        barrierPaint);
    canvas.drawRect(Rect.fromLTWH(0, lowerBarrier - 10, size.width, 10),
        barrierDragLimitPain);
  }

  @override
  bool shouldRepaint(covariant TextBlockPainter oldDelegate) => true;
}
