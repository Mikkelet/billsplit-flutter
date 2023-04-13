class Person {
  final String uid;
  final String _name;
  final String pfpUrl;

  // modifiable values
  late String nameState = _name;

  Person(this.uid, String name, this.pfpUrl) : _name = name;

  Person.dummy(num seed)
      : uid = "P$seed",
        _name = "Person $seed",
        pfpUrl = "";
}
