// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDTO _$EventDTOFromJson(Map<String, dynamic> json) => EventDTO(
      json['id'] as String,
      PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      json['timeStamp'] as num,
      json['type'] as String,
    );

Map<String, dynamic> _$EventDTOToJson(EventDTO instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'createdBy': instance.createdBy.toJson(),
      'timeStamp': instance.timeStamp,
    };

GroupExpenseDTO _$GroupExpenseDTOFromJson(Map<String, dynamic> json) =>
    GroupExpenseDTO(
      json['id'] as String,
      PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      json['timeStamp'] as num,
      json['type'] as String,
      json['description'] as String,
      PersonDTO.fromJson(json['payee'] as Map<String, dynamic>),
      json['sharedExpense'] as num,
      (json['individualExpenses'] as List<dynamic>)
          .map((e) => IndividualExpenseDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupExpenseDTOToJson(GroupExpenseDTO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'createdBy': instance.createdBy.toJson(),
      'timeStamp': instance.timeStamp,
      'description': instance.description,
      'payee': instance.payee.toJson(),
      'sharedExpense': instance.sharedExpense,
      'individualExpenses':
          instance.individualExpenses.map((e) => e.toJson()).toList(),
    };

PaymentDTO _$PaymentDTOFromJson(Map<String, dynamic> json) => PaymentDTO(
      json['id'] as String,
      PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      json['timeStamp'] as num,
      json['type'] as String,
      PersonDTO.fromJson(json['paidTo'] as Map<String, dynamic>),
      json['amount'] as num,
    );

Map<String, dynamic> _$PaymentDTOToJson(PaymentDTO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'createdBy': instance.createdBy.toJson(),
      'timeStamp': instance.timeStamp,
      'paidTo': instance.paidTo.toJson(),
      'amount': instance.amount,
    };
