import 'package:billsplit_flutter/domain/use_cases/scan_receipt_usecase2.dart';
import 'package:flutter/material.dart';

class TextBlockPainter extends CustomPainter {
  final Iterable<ScannedReceiptItem> textBlocks;
  final double upperBarrier;
  final double lowerBarrier;
  final scale = 0.19;

  TextBlockPainter(this.textBlocks, this.upperBarrier, this.lowerBarrier);

  @override
  void paint(Canvas canvas, Size size) {
    bool even = false;
    for (var text in textBlocks) {
      final textBlock = text.boundaryBox;
      final paint = Paint();
      paint.style = PaintingStyle.stroke;
      paint.color = even ? Colors.green : Colors.blue;
      even = !even;
      paint.strokeWidth = 2;
      canvas.drawRect(
          Rect.fromLTWH(textBlock.left * scale, (textBlock.top * scale),
              textBlock.width * scale, textBlock.height * scale),
          paint);
    }

    final barrierPaint = Paint()..color = Colors.black.withAlpha(200);
    final barrierDragLimitPain = Paint()..color = Colors.green;

    barrierPaint.style = PaintingStyle.fill;
    barrierPaint.strokeWidth = 2;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, canvas.getLocalClipBounds().width, upperBarrier),
        barrierPaint);
    canvas.drawRect(
        Rect.fromLTWH(
            0, upperBarrier - 10, canvas.getLocalClipBounds().width, 10),
        barrierDragLimitPain);

    canvas.drawRect(
        Rect.fromLTWH(0, lowerBarrier, canvas.getLocalClipBounds().width,
            canvas.getLocalClipBounds().height),
        barrierPaint);
    canvas.drawRect(
        Rect.fromLTWH(
            0, lowerBarrier - 10, canvas.getLocalClipBounds().width, 10),
        barrierDragLimitPain);
  }

  @override
  bool shouldRepaint(covariant TextBlockPainter oldDelegate) => true;
}
