// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_expense_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualExpenseDTO _$IndividualExpenseDTOFromJson(
        Map<String, dynamic> json) =>
    IndividualExpenseDTO(
      PersonDTO.fromJson(json['person'] as Map<String, dynamic>),
      json['expense'] as num,
      json['isParticipant'] as bool,
    );

Map<String, dynamic> _$IndividualExpenseDTOToJson(
        IndividualExpenseDTO instance) =>
    <String, dynamic>{
      'person': instance.person,
      'expense': instance.expense,
      'isParticipant': instance.isParticipant,
    };
