import 'package:billsplit_flutter/data/remote/dtos/debts_dto.dart';
import 'package:billsplit_flutter/domain/models/debt.dart';

extension DebtExt on List<Debt> {
  List<DebtDTO> toDTOs() => map((e) => e.toDTO()).toList();
}

extension DebtsExt on Debt {
  DebtDTO toDTO() => DebtDTO(userId, owes);
}

extension DebtDtosExt on Iterable<DebtDTO> {
  Iterable<Debt> toDebts() => map((e) => e.toDebt());
}

extension DebtDtoExt on DebtDTO {
  Debt toDebt() => Debt(userId, owes);
}
