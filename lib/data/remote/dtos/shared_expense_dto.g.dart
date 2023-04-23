// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_expense_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedExpenseDTO _$SharedExpenseDTOFromJson(Map<String, dynamic> json) =>
    SharedExpenseDTO(
      json['description'] as String,
      (json['participants'] as List<dynamic>)
          .map((e) => PersonDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['expense'] as num,
    );

Map<String, dynamic> _$SharedExpenseDTOToJson(SharedExpenseDTO instance) =>
    <String, dynamic>{
      'description': instance.description,
      'participants': instance.participants.map((e) => e.toJson()).toList(),
      'expense': instance.expense,
    };
