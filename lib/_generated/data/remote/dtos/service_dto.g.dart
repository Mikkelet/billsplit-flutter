// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/dtos/service_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceDTO _$ServiceDTOFromJson(Map json) => ServiceDTO(
  id: json['id'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  monthlyExpense: json['monthlyExpense'] as num,
  createdBy: PersonDTO.fromJson(
    Map<String, dynamic>.from(json['createdBy'] as Map),
  ),
  participants: (json['participants'] as List<dynamic>).map(
    (e) => PersonDTO.fromJson(Map<String, dynamic>.from(e as Map)),
  ),
  payer: PersonDTO.fromJson(Map<String, dynamic>.from(json['payer'] as Map)),
  currency: json['currency'] as String,
);

Map<String, dynamic> _$ServiceDTOToJson(ServiceDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'monthlyExpense': instance.monthlyExpense,
      'payer': instance.payer.toJson(),
      'createdBy': instance.createdBy.toJson(),
      'currency': instance.currency,
      'participants': instance.participants.map((e) => e.toJson()).toList(),
    };
