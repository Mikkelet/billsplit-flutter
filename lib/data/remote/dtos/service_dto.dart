import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_dto.g.dart';

@JsonSerializable()
class ServiceDTO {
  final String id;
  final String name;
  final String imageUrl;
  final num monthlyExpense;
  final PersonDTO payer;
  final PersonDTO createdBy;
  final List<PersonDTO> participants;

  ServiceDTO(this.id, this.name, this.imageUrl, this.monthlyExpense, this.createdBy, this.participants, this.payer);

  factory ServiceDTO.fromJson(Json json) => _$ServiceDTOFromJson(json);

  Json toJson() => _$ServiceDTOToJson(this);
}

/**
 * data class ServiceDTO(
    val id: String,
    val name: String,
    val createdBy: PersonDTO,
    val imageUrl: String,
    val monthlyExpense: Float,
    val payer: PersonDTO,
    val participants: List<PersonDTO>
    ) {
 */
