import 'package:flutter/material.dart';

class ScannedReceiptItem {
  final num expense;
  final String description;
  final Rect boundaryBox;

  ScannedReceiptItem(
      {required this.expense,
        required this.description,
        required this.boundaryBox});
}
