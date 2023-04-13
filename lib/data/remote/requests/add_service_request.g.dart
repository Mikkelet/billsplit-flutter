// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_service_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AddServiceRequestToJson(AddServiceRequest instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'service': instance.service.toJson(),
    };

AddServiceResponse _$AddServiceResponseFromJson(Map<String, dynamic> json) =>
    AddServiceResponse(
      ServiceDTO.fromJson(json['service'] as Map<String, dynamic>),
    );
