import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/dtos/surcharge_dto.g.dart';

@JsonSerializable()
class SurchargeDTO {
  final String name;
  final String type; // 'fixed' or 'percentage'
  final num value;

  SurchargeDTO({required this.name, required this.type, required this.value});

  Json toJson() => _$SurchargeDTOToJson(this);

  factory SurchargeDTO.fromJson(Json json) => _$SurchargeDTOFromJson(json);
}
