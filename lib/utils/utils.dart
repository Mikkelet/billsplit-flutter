import 'package:intl/intl.dart';

var formatter2dec = NumberFormat('#,###.##');
var formatter0dec = NumberFormat('#,###');

extension NumExt on num {
  String fmt2dec() => remainder(1) != 0
      ? formatter2dec.format(this)
      : formatter0dec.format(this);

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
