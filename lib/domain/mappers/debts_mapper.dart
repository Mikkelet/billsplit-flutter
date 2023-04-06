import 'package:billsplit_flutter/data/remote/dtos/debts_dto.dart';

extension DebtsExt on List<DebtDTO> {
  List<Map<String, num>> toDebts() => map((e) => e.toDebt()).toList();
}

extension DebtExt on DebtDTO {
  Map<String, num> toDebt() => {userId: owes};
}
