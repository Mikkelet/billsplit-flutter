import 'package:billsplit_flutter/domain/models/scanned_receipt_item.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ScannedReceipt {
  final XFile xFile;
  final Size imageSize;
  final Iterable<ScannedReceiptItem> items;

  ScannedReceipt(this.imageSize, this.items, this.xFile);

  double getScaleFactor(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    return windowSize.width / imageSize.width;
  }
}
