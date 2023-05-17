import 'package:intl/intl.dart';

var formatter2dec = NumberFormat('#,###.##');
var formatter4dec = NumberFormat('#.####');
var formatter0dec = NumberFormat('#,###');

extension NumExt on num {
  String fmt2dec() {
    if (this == 0) return "0";
    if (this < 1) return formatter4dec.format(this);
    return remainder(1) != 0
        ? formatter2dec.format(this)
        : formatter0dec.format(this);
  }

  String fmtTextField() => fmt2dec().replaceAll(",", "");
}

const List<String> monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
