// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/remote/dtos/service_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceDTO _$ServiceDTOFromJson(Map<String, dynamic> json) => ServiceDTO(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      monthlyExpense: json['monthlyExpense'] as num,
      createdBy: PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => PersonDTO.fromJson(e as Map<String, dynamic>)),
      payer: PersonDTO.fromJson(json['payer'] as Map<String, dynamic>),
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
