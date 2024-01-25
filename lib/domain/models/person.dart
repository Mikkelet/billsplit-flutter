import 'package:billsplit_flutter/domain/models/phone_number.dart';

class Person {
  final String uid;
  final String _name;
  final String _pfpUrl;
  final PhoneNumber _phoneNumber;
  final String email;
  final bool isGuest;

  // modifiable values
  late String nameState = _name;
  late String pfpUrlState = _pfpUrl;
  late PhoneNumber phoneNumberState = _phoneNumber;

  Person({
    required this.uid,
    required String name,
    this.isGuest = false,
    String pfpUrl = "",
    PhoneNumber phoneNumber = const PhoneNumber.none(),
    this.email = "",
  })  : _name = name,
        _phoneNumber = phoneNumber,
        _pfpUrl = pfpUrl;

  Person.temp(): this(uid: "", name: "New Person");
  Person.dummy(num seed) : this(uid: "P$seed", name: "Person $seed");

  String get displayName => nameState.isEmpty ? "Splitsby user" : nameState;


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
