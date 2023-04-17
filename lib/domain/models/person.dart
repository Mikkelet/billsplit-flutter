class Person {
  final String uid;
  final String _name;
  final String pfpUrl;
  final String email;

  // modifiable values
  late String nameState = _name;

  Person(this.uid, String name, {this.pfpUrl = "", this.email = ""})
      : _name = name.isEmpty ? "Splitsby user" : name;

  Person.dummy(num seed)
      : uid = "P$seed",
        _name = "Person $seed",
        email = "dummy@test.dk",
        pfpUrl = "";
}
