import 'package:billsplit_flutter/domain/models/person.dart';

abstract class Event {
  final String id;
  final Person createdBy;
  final num timestamp;

  Event(this.id, this.createdBy, this.timestamp);
}