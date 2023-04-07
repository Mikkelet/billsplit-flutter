import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

extension PeopleDTOExt on List<PersonDTO> {
  List<Person> toPeople() {
    return map((e) => e.toPerson()).toList();
  }
}

extension PersonDTOExt on PersonDTO {
  Person toPerson() => Person(id, name, pfpUrl);
}

extension PeopleExt on List<Person> {
  List<PersonDTO> toDTO() => map((e) => e.toDTO()).toList();
}

extension PersonExt on Person {
  PersonDTO toDTO() => PersonDTO(uid, name, pfpUrl);
}
