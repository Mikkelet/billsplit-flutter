import 'dart:io';
import 'dart:math';
import 'package:billsplit_flutter/domain/models/scanned_receipt.dart';
import 'package:billsplit_flutter/domain/models/scanned_receipt_item.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ScanReceiptUseCase {
  late Size windowSize;
  late Size imageSize;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<ScannedReceipt> launch(Size windowSize, XFile file) async {
    this.windowSize = windowSize;
    final inputImage = InputImage.fromFilePath(file.path);
    File image = File(file.path); // Or any other way to get a File instance.
    final decodedImage = await decodeImageFromList(image.readAsBytesSync());
    imageSize =
        Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    textRecognizer.close();
    final texts = recognizedText.blocks
        .map((e) => e.lines)
        .flatMap()
        .map((e) => e.elements)
        .flatMap()
        .map((e) => TextElement(
            text: e.text,
            boundingBox: translateRect(e.boundingBox),
            cornerPoints: e.cornerPoints));
    final expenses = _deriveExpenses(imageSize, texts);
    return ScannedReceipt(imageSize, expenses, file);
  }

  Iterable<ScannedReceiptItem> _deriveExpenses(
      Size imageSize, Iterable<TextElement> texts) {
    // assume all prices are on the right side of the receipt
    final double verticalCenter = windowSize.width / 2;
    final rightSideTexts =
        texts.where((element) => element.boundingBox.left > verticalCenter);
    final textsWithNumbers = rightSideTexts
        .where((element) => element.text.contains(RegExp("[0-9]")))
        .where((element) => element.text.length < 10)
        .map((e) {
      final cleanText =
          e.text.replaceAll(RegExp("[^0-9.,-]"), "").replaceAll(",", ".");

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

      // The idea here is that every expense number shoots a line to the left of it and grabs any text that is touching the line.
      // We then use that text as the description regardless of its content.
      // define the vertical center of price boundary box
      final verticalCenter =
          expense.boundingBox.top + expense.boundingBox.height / 2;

      // Find every textline that matches the constraints
      final withinVertCenter = texts.where((element) =>
          element.boundingBox.top < verticalCenter &&
          element.boundingBox.left < expense.boundingBox.left &&
          element.boundingBox.bottom > verticalCenter);

      print(withinVertCenter.map((e) => e.text));
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

  double get scaleFactor => windowSize.width / imageSize.width;

  Rect translateRect(Rect rect) {
    if (Platform.isIOS) {
      // ios platform is both rotation -90 degrees and mirrored
      // so we need to flip H and W, and T and L, and mirror the L to the other side
      // Thanks Apple
      final left = imageSize.width - rect.top - rect.height;
      return Rect.fromLTWH(left * scaleFactor, rect.left * scaleFactor,
          rect.height * scaleFactor, rect.width * scaleFactor);
    }
    return Rect.fromLTWH(rect.left * scaleFactor, rect.top * scaleFactor,
        rect.width * scaleFactor, rect.height * scaleFactor);
  }
}
