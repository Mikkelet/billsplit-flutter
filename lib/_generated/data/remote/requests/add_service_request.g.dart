// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/requests/add_service_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AddServiceRequestToJson(AddServiceRequest instance) =>
    <String, dynamic>{'service': instance.service.toJson()};

AddServiceResponse _$AddServiceResponseFromJson(Map json) => AddServiceResponse(
  ServiceDTO.fromJson(Map<String, dynamic>.from(json['service'] as Map)),
);
