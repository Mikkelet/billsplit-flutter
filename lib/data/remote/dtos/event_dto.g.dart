// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDTO _$EventDTOFromJson(Map<String, dynamic> json) => EventDTO(
      id: json['id'] as String,
      createdBy: PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as num,
      type: json['type'] as String,
    );

Map<String, dynamic> _$EventDTOToJson(EventDTO instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'createdBy': instance.createdBy.toJson(),
      'timestamp': instance.timestamp,
    };

GroupExpenseDTO _$GroupExpenseDTOFromJson(Map<String, dynamic> json) =>
    GroupExpenseDTO(
      id: json['id'] as String,
      createdBy: PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as num,
      type: json['type'] as String? ?? "expense",
      description: json['description'] as String,
      currency: CurrencyDTO.fromJson(json['currency'] as Map<String, dynamic>),
      tempParticipants: (json['tempParticipants'] as List<dynamic>)
          .map((e) => PersonDTO.fromJson(e as Map<String, dynamic>)),
      payee: PersonDTO.fromJson(json['payee'] as Map<String, dynamic>),
      sharedExpenses: (json['sharedExpenses'] as List<dynamic>)
          .map((e) => SharedExpenseDTO.fromJson(e as Map<String, dynamic>)),
    );

Map<String, dynamic> _$GroupExpenseDTOToJson(GroupExpenseDTO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'createdBy': instance.createdBy.toJson(),
      'timestamp': instance.timestamp,
      'description': instance.description,
      'payee': instance.payee.toJson(),
      'currency': instance.currency.toJson(),
      'sharedExpenses': instance.sharedExpenses.map((e) => e.toJson()).toList(),
      'tempParticipants':
          instance.tempParticipants.map((e) => e.toJson()).toList(),
    };

PaymentDTO _$PaymentDTOFromJson(Map<String, dynamic> json) => PaymentDTO(
      id: json['id'] as String,
      createdBy: PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as num,
      type: json['type'] as String? ?? "payment",
      currency: CurrencyDTO.fromJson(json['currency'] as Map<String, dynamic>),
      paidBy: PersonDTO.fromJson(json['paidBy'] as Map<String, dynamic>),
      paidTo: PersonDTO.fromJson(json['paidTo'] as Map<String, dynamic>),
      amount: json['amount'] as num,
    );

Map<String, dynamic> _$PaymentDTOToJson(PaymentDTO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'createdBy': instance.createdBy.toJson(),
      'timestamp': instance.timestamp,
      'paidTo': instance.paidTo.toJson(),
      'amount': instance.amount,
      'currency': instance.currency.toJson(),
      'paidBy': instance.paidBy.toJson(),
    };
