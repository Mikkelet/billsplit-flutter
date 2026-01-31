// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/remote/dtos/debts_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DebtDTO _$DebtDTOFromJson(Map<String, dynamic> json) => DebtDTO(
      json['userId'] as String,
      json['owes'] as num,
    );

Map<String, dynamic> _$DebtDTOToJson(DebtDTO instance) => <String, dynamic>{
      'userId': instance.userId,
      'owes': instance.owes,
    };
