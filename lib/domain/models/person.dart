import 'package:billsplit_flutter/domain/models/phone_number.dart';

class Person {
  final String uid;
  final String _name;
  final String _pfpUrl;
  final PhoneNumber _phoneNumber;
  final String email;

  // modifiable values
  late String nameState = _name;
  late String pfpUrlState = _pfpUrl;
  late PhoneNumber phoneNumberState = _phoneNumber;

  Person(
    this.uid,
    String name, {
    String pfpUrl = "",
    PhoneNumber phoneNumber = const PhoneNumber.none(),
    this.email = "",
  })  : _name = name,
        _phoneNumber = phoneNumber,
        _pfpUrl = pfpUrl;

  Person.temp()
      : uid = "",
        email = "",
        _phoneNumber = const PhoneNumber.none(),
        _name = "New person",
        _pfpUrl = "";

  String get displayName => nameState.isEmpty ? "Splitsby user" : nameState;

  Person.dummy(num seed)
      : uid = "P$seed",
        _name = "Person $seed",
        email = "dummy@test.dk",
        _phoneNumber = const PhoneNumber.none(),
        _pfpUrl = "";

  @override
  int get hashCode => uid.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! Person) return false;
    return uid == other.uid;
  }

  @override
  String toString() {
    return "Person(id=$uid, name=$_name)";
  }

  void resetChanges() {
    pfpUrlState = _pfpUrl;
    nameState = _name;
  }
}
