import 'package:billsplit_flutter/data/remote/dtos/debts_dto.dart';
import 'package:billsplit_flutter/domain/models/Debt.dart';

extension DebtExt on List<Debt> {
  List<DebtDTO> toDTOs() => map((e) => e.toDTO()).toList();
}

extension DebtsExt on Debt {
  DebtDTO toDTO() => DebtDTO(userId, owes);
}

extension DebtDtosExt on List<DebtDTO> {
  List<Debt> toDebts() => map((e) => e.toDebt()).toList();
}

extension DebtDtoExt on DebtDTO {
  Debt toDebt() => Debt(userId, owes);
}
