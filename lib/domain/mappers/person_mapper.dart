import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

extension PeopleDTOExt on Iterable<PersonDTO> {
  List<Person> toPeople() {
    return map((e) => e.toPerson()).toList();
  }
}

extension PersonDTOExt on PersonDTO {
  Person toPerson() => Person(id, name, pfpUrl: pfpUrl);
}

extension PeopleExt on Iterable<Person> {
  Iterable<PersonDTO> toDTO() => map((e) => e.toDTO());
}

extension PersonExt on Person {
  PersonDTO toDTO() => PersonDTO(uid, nameState, pfpUrlState);
}
