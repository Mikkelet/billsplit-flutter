// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/remote/dtos/person_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDTO _$PersonDTOFromJson(Map<String, dynamic> json) => PersonDTO(
      json['id'] as String,
      json['name'] as String,
      json['pfpUrl'] as String,
    );

Map<String, dynamic> _$PersonDTOToJson(PersonDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pfpUrl': instance.pfpUrl,
    };
