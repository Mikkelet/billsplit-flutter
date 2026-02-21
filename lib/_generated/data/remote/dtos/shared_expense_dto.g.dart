// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/dtos/shared_expense_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedExpenseDTO _$SharedExpenseDTOFromJson(Map json) => SharedExpenseDTO(
  json['description'] as String,
  (json['participants'] as List<dynamic>).map(
    (e) => PersonDTO.fromJson(Map<String, dynamic>.from(e as Map)),
  ),
  json['expense'] as num,
);

Map<String, dynamic> _$SharedExpenseDTOToJson(SharedExpenseDTO instance) =>
    <String, dynamic>{
      'description': instance.description,
      'participants': instance.participants.map((e) => e.toJson()).toList(),
      'expense': instance.expense,
    };
