class Person {
  final String uid;
  final String _name;
  final String _pfpUrl;
  final String email;

  // modifiable values
  late String nameState = _name;
  late String pfpUrlState = _pfpUrl;

  Person(this.uid, String name, {String pfpUrl = "", this.email = ""})
      : _name = name.isEmpty ? "Splitsby user" : name,
        _pfpUrl = pfpUrl;

  Person.dummy(num seed)
      : uid = "P$seed",
        _name = "Person $seed",
        email = "dummy@test.dk",
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

  void resetChanges(){
    pfpUrlState = _pfpUrl;
    nameState = _name;
  }
}
