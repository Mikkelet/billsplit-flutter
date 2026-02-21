// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/dtos/event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDTO _$EventDTOFromJson(Map json) => EventDTO(
  id: json['id'] as String,
  createdBy: PersonDTO.fromJson(
    Map<String, dynamic>.from(json['createdBy'] as Map),
  ),
  timestamp: (json['timestamp'] as num).toInt(),
  type: json['type'] as String,
);

Map<String, dynamic> _$EventDTOToJson(EventDTO instance) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'createdBy': instance.createdBy.toJson(),
  'timestamp': instance.timestamp,
};

GroupExpenseDTO _$GroupExpenseDTOFromJson(Map json) => GroupExpenseDTO(
  id: json['id'] as String,
  createdBy: PersonDTO.fromJson(
    Map<String, dynamic>.from(json['createdBy'] as Map),
  ),
  timestamp: (json['timestamp'] as num).toInt(),
  type: json['type'] as String? ?? "expense",
  date: json['date'] as String,
  receiptImageUrl: json['receiptImageUrl'] as String,
  description: json['description'] as String,
  currency: CurrencyDTO.fromJson(
    Map<String, dynamic>.from(json['currency'] as Map),
  ),
  tempParticipants: (json['tempParticipants'] as List<dynamic>).map(
    (e) => PersonDTO.fromJson(Map<String, dynamic>.from(e as Map)),
  ),
  payee: PersonDTO.fromJson(Map<String, dynamic>.from(json['payee'] as Map)),
  sharedExpenses: (json['sharedExpenses'] as List<dynamic>).map(
    (e) => SharedExpenseDTO.fromJson(Map<String, dynamic>.from(e as Map)),
  ),
  surcharges: (json['surcharges'] as List<dynamic>).map(
    (e) => SurchargeDTO.fromJson(Map<String, dynamic>.from(e as Map)),
  ),
);

Map<String, dynamic> _$GroupExpenseDTOToJson(
  GroupExpenseDTO instance,
) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'createdBy': instance.createdBy.toJson(),
  'timestamp': instance.timestamp,
  'description': instance.description,
  'payee': instance.payee.toJson(),
  'currency': instance.currency.toJson(),
  'date': instance.date,
  'sharedExpenses': instance.sharedExpenses.map((e) => e.toJson()).toList(),
  'tempParticipants': instance.tempParticipants.map((e) => e.toJson()).toList(),
  'receiptImageUrl': instance.receiptImageUrl,
  'surcharges': instance.surcharges.map((e) => e.toJson()).toList(),
};

PaymentDTO _$PaymentDTOFromJson(Map json) => PaymentDTO(
  id: json['id'] as String,
  createdBy: PersonDTO.fromJson(
    Map<String, dynamic>.from(json['createdBy'] as Map),
  ),
  timestamp: (json['timestamp'] as num).toInt(),
  type: json['type'] as String? ?? "payment",
  currency: CurrencyDTO.fromJson(
    Map<String, dynamic>.from(json['currency'] as Map),
  ),
  paidBy: PersonDTO.fromJson(Map<String, dynamic>.from(json['paidBy'] as Map)),
  paidTo: PersonDTO.fromJson(Map<String, dynamic>.from(json['paidTo'] as Map)),
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
