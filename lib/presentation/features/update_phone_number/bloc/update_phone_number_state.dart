import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class InvalidPhoneNumberEvent extends Main {}

class PhoneNumberLoaded extends Main {}

class UpdateStep extends Main {
  final int step;

  UpdateStep({required this.step});

}

class UpdateNumberSuccess extends Main {}