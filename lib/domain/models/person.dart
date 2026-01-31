import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';

class Person {
  final String uid;
  final String _name;
  final String _pfpUrl;
  final PhoneNumber _phoneNumber;
  final String email;
  final bool isGuest;

  // modifiable values
  late final MutableState<String> nameState = _name.obs();
  late final MutableState<String> pfpUrlState = _pfpUrl.obs();
  late final MutableState<PhoneNumber> phoneNumberState = _phoneNumber.obs();

  Person({
    required this.uid,
    required String name,
    this.isGuest = false,
    String pfpUrl = "",
    PhoneNumber phoneNumber = const PhoneNumber.none(),
    this.email = "",
  })  : _name = name.isEmpty ? "Splitsby user" : name,
        _phoneNumber = phoneNumber,
        _pfpUrl = pfpUrl;

  Person.temp() : this(uid: "", name: "New Person");

  Person.dummy(num seed) : this(uid: "P$seed", name: "Person $seed");

  String get displayName =>
      nameState.value.isEmpty ? "Splitsby user" : nameState.value;

  Stream<String> get displayNameStream => nameState.stateStream
      .map((name) => name.isEmpty ? "Splitsby user" : name);

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
    pfpUrlState.value = _pfpUrl;
    nameState.value = _name;
  }
}
