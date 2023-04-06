// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceDTO _$ServiceDTOFromJson(Map<String, dynamic> json) => ServiceDTO(
      json['id'] as String,
      json['name'] as String,
      json['imageUrl'] as String,
      json['monthlyExpense'] as num,
      PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      (json['participants'] as List<dynamic>)
          .map((e) => PersonDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceDTOToJson(ServiceDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'monthlyExpense': instance.monthlyExpense,
      'createdBy': instance.createdBy,
      'participants': instance.participants,
    };
