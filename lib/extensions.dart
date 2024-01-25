
import 'package:billsplit_flutter/domain/models/person.dart';

extension MapExt<T> on Iterable<Iterable<T>> {
  Iterable<T> flatMap() {
    return fold([], (previousValue, element) => [...previousValue, ...element]);
  }
}

extension PersonExt on Person {
  bool isTemp(){
    return uid.startsWith("temp");
  }
}

typedef Json = Map<String, dynamic>;

T builder<T>(T Function() build) => build();