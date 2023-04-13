extension NumExt on num {
  String fmt2dec() => remainder(1) != 0 ? toStringAsFixed(2) : toInt().toString();
}