import 'dart:math';
import 'dart:ui';

import 'package:google_ml_kit/google_ml_kit.dart';

class ScanReceiptUseCase {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<List<num>> launch(String uri) async {
    final List<num> expenses = [];
    final inputImage = InputImage.fromFilePath(uri);
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    for (TextBlock block in recognizedText.blocks) {
      final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          if (element.text.contains(".")) {
            print(element.text);
            try {
              final expense = num.parse(element.text);
              expenses.add(expense);
            } catch(_) {
              print("${element.text} is not a number");
            }
          }
        }
      }
    }
    textRecognizer.close();
    return expenses;
  }
}
