import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
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

int get nowEpoch => DateTime.now().millisecondsSinceEpoch;

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

extension ListPersonExt on Iterable<Person> {
  bool equals(Iterable<Person> other) {
    if (other.length != length) return false;
    final otherSorted = other.map((e) => e.uid).sortedBy((element) => element);
    final thisSorted = map((e) => e.uid).sortedBy((element) => element);
    return listEquals(thisSorted, otherSorted);
  }
}

extension ListSharedExpenseExt on Iterable<SharedExpense> {
  bool equals(Iterable<SharedExpense> other) {
    if(length != other.length) return false;
    return listEquals(toList(), other.toList());
  }
}
