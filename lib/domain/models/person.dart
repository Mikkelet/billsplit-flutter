import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../_generated/domain/models/person.freezed.dart';

@freezed
abstract class Person with _$Person {
  const factory Person({
    @Default("") String uid,
    @Default("") String name,
    @Default("") String pfpUrl,
    @Default("") String email,
    @Default(PhoneNumber()) PhoneNumber phoneNumber,
    @Default(false) bool isGuest,
  }) = _Person;

  const Person._();

  factory Person.temp() => Person(uid: "", name: "New Person");

  factory Person.dummy(num seed) => Person(uid: "P$seed", name: "Person $seed");

  String get displayName => name.isEmpty ? "Splitsby user" : name;
}
