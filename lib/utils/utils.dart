import 'package:intl/intl.dart';

var formatter2dec = NumberFormat('#,###.##');
var formatter4dec = NumberFormat('#.####');
var formatter0dec = NumberFormat('#,###');

extension NumExt on num {
  String fmt2dec({bool readOnly = true}) {
    if (this == 0) return readOnly ? "0.00" : "";
    if (this < 1) return formatter4dec.format(this);
    return remainder(1) != 0
        ? formatter2dec.format(this)
        : formatter0dec.format(this);
  }

  String fmtTextField() => fmt2dec(readOnly: false).replaceAll(",", "");
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
