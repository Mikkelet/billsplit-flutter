import 'package:billsplit_flutter/data/remote/dtos/surcharge_dto.dart';
import 'package:billsplit_flutter/domain/models/surcharge.dart';

extension SurchargeDtoExt on SurchargeDTO {
  Surcharge toSurcharge() {
    final SurchargeType surchargeType;
    switch (type) {
      case "percentage":
        surchargeType = SurchargeType.percentage;
      case "fixed":
        surchargeType = SurchargeType.fixed;
      default:
        throw Exception(
            "Surcharge type could not be determined, unknown value $type");
    }
    return Surcharge(name: name, type: surchargeType, value: value);
  }
}

extension SurchargeExt on Surcharge {
  SurchargeDTO toDTO() {
    return SurchargeDTO(name: name, type: type.name, value: value);
  }
}

extension ListSurchargeDtoExt on Iterable<SurchargeDTO> {
  Iterable<Surcharge> toSurcharges(){
    return map((e) => e.toSurcharge());
  }
}

extension ListSurchargeExt on Iterable<Surcharge> {
  Iterable<SurchargeDTO> toSurcharges(){
    return map((e) => e.toDTO());
  }
}