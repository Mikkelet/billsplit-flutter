import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/group/bloc/debt_state.freezed.dart';

@freezed
abstract class DebtState with _$DebtState {
  const factory DebtState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default(Group()) Group group,
    @Default(Person()) Person debtee,
    @Default(0) double amount,
    @Default("") String currency,
  }) = _DebtState;
}
