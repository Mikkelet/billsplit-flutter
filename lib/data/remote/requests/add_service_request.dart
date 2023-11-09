import 'package:billsplit_flutter/data/remote/dtos/service_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/requests/add_service_request.g.dart';

@JsonSerializable(createFactory: false)
class AddServiceRequest {
  final ServiceDTO service;

  AddServiceRequest(this.service);

  Json toJson() => _$AddServiceRequestToJson(this);
}

@JsonSerializable(createToJson: false)
class AddServiceResponse {
  final ServiceDTO service;

  AddServiceResponse(this.service);

  factory AddServiceResponse.fromJson(Json json) =>
      _$AddServiceResponseFromJson(json);
}
