import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

extension PeopleExt on List<PersonDTO> {
  List<Person> toPeople() {
    return map((e) => e.toPerson()).toList();
  }
}

extension PersonExt on PersonDTO {
  Person toPerson() => Person(id, name, pfpUrl);
}
