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
  final String currency;
  final List<PersonDTO> participants;

  ServiceDTO(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.monthlyExpense,
      required this.createdBy,
      required this.participants,
      required this.payer,
      required this.currency});

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
