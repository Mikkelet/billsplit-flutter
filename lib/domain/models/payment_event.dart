import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

class Payment extends Event {
  final Person paidTo;
  final num amount;
  final Currency currency;

  Payment(
      {required String id,
      required Person createdBy,
      required num timestamp,
      required this.paidTo,
      required this.currency,
      required this.amount})
      : super(id, createdBy, timestamp);

  @override
  String toString() {
    return "Payment(id=$id, createdBy=$createdBy, paidTo=$paidTo, amount=$amount)";
  }
}
