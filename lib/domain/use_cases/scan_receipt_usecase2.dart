import 'dart:math';
import 'dart:ui';

import 'package:billsplit_flutter/extensions.dart';
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ScanReceiptUseCase2 {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<Iterable<ScannedReceiptItem>> launch(XFile file) async {
    final inputImage = InputImage.fromFilePath(file.path);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    final texts = recognizedText.blocks
        .map((e) => e.lines)
        .flatMap()
        .map((e) => e.elements)
        .flatMap();

    return _deriveExpenses(inputImage, texts);
  }

  Iterable<ScannedReceiptItem> _deriveExpenses(
      InputImage inputImage, Iterable<TextElement> texts) {
    final imageSize = inputImage.inputImageData?.size ?? const Size(1080, 1920);
    // assume all prices are on the right side of the receipt
    final double verticalCenter = imageSize.width / 2;
    final double bottomRect = findTotal(texts)?.top ?? imageSize.height;
    final rightSideTexts = texts
        .where((element) => element.boundingBox.left > verticalCenter)
        .where((element) => element.boundingBox.bottom < bottomRect);
    final textsWithNumbers = rightSideTexts
        .where((element) => element.text.contains(RegExp("[0-9]")))
        //.where((element) => (element.text.contains(".") || element.text.contains(",")))
        .where((element) => element.text.length < 10)
        .map((e) {
      final cleanText =
          e.text.replaceAll(RegExp("[^0-9.,]"), "").replaceAll(",", ".");
      return TextElement(
          text: cleanText,
          boundingBox: e.boundingBox,
          cornerPoints: e.cornerPoints);
    });

    return _findExpenseDescriptions(texts, textsWithNumbers);
  }

  Iterable<ScannedReceiptItem> _findExpenseDescriptions(
      Iterable<TextElement> texts, Iterable<TextElement> expenses) {
    final List<ScannedReceiptItem> receiptItems = [];

    for (var expense in expenses) {
      num expenseNum = 0;
      try {
        expenseNum = num.parse(expense.text);
      } catch (e) {
        print("${expense.text} cannot be parsed");
      }

      // define the vertical center of price boundary box
      final verticalCenter =
          expense.boundingBox.top + expense.boundingBox.height / 2;

      // Find every textline that matches the constraints
      final withinVertCenter = texts.where((element) =>
          element.boundingBox.top < verticalCenter &&
          element.boundingBox.left < expense.boundingBox.left &&
          element.boundingBox.bottom > verticalCenter);

      // if empty, just return the prices
      if (withinVertCenter.isEmpty) {
        final receiptItem = ScannedReceiptItem(
            expense: expenseNum,
            description: "",
            boundaryBox: expense.boundingBox);
        receiptItems.add(receiptItem);
        continue;
      }

      // Combine all elements into one string
      final description = withinVertCenter.fold(
          "", (previousValue, element) => "$previousValue ${element.text}");

      // Find left-most element
      final minLeft = withinVertCenter.fold(
          double.infinity,
          (previousValue, element) =>
              min(previousValue, element.boundingBox.left));

      // find top-most element
      final minTop = withinVertCenter.fold(
          double.infinity,
          (previousValue, element) =>
              min(previousValue, element.boundingBox.top));

      // calculate height
      final height = max(withinVertCenter.first.boundingBox.bottom,
              expense.boundingBox.bottom) -
          minTop;

      // map to receipt item
      final item = ScannedReceiptItem(
          expense: expenseNum,
          description: description,
          boundaryBox: Rect.fromLTWH(
              minLeft, minTop, expense.boundingBox.right - minLeft, height));
      receiptItems.add(item);
    }
    return receiptItems;
  }

  Rect? findTotal(Iterable<TextElement> texts) {
    return texts
        .firstWhereOrNull(
            (element) => element.text.toLowerCase().contains("total"))
        ?.boundingBox;
  }
}

class ScannedReceiptItem {
  final num expense;
  final String description;
  final Rect boundaryBox;

  ScannedReceiptItem(
      {required this.expense,
      required this.description,
      required this.boundaryBox});
}
