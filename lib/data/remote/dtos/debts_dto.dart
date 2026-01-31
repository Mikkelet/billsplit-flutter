import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/dtos/debts_dto.g.dart';

@JsonSerializable()
class DebtDTO {
  final String userId;
  final num owes;

  DebtDTO(this.userId, this.owes);

  factory DebtDTO.fromJson(Json json) => _$DebtDTOFromJson(json);

  Json toJson() => _$DebtDTOToJson(this);
}
