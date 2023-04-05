class Person {
  final String name;
  final String uid;

  Person({required this.uid, required this.name});

  Person.dummy(num seed)
      : uid = "P$seed",
        name = "Person $seed";
}
