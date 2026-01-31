// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/remote/dtos/surcharge_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurchargeDTO _$SurchargeDTOFromJson(Map<String, dynamic> json) => SurchargeDTO(
  name: json['name'] as String,
  type: json['type'] as String,
  value: json['value'] as num,
);

Map<String, dynamic> _$SurchargeDTOToJson(SurchargeDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'value': instance.value,
    };
