
class Person {
  final String uid;
  final String name;
  final String pfpUrl;

  Person(this.uid, this.name, this.pfpUrl);

  Person.dummy(num seed)
      : uid = "P$seed",
        name = "Person $seed",
        pfpUrl = "";
}
