import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:flutter/services.dart';
import 'package:phone_number/phone_number.dart' as phone_num_parser;

class ParsePhoneNumberUseCase {
  Future<PhoneNumber?> launch(String phoneNumber) async {
    if (phoneNumber.isEmpty) return null;
    try {
      final parse = await phone_num_parser.PhoneNumberUtil().parse(phoneNumber);
      return PhoneNumber(
        phoneNumber: parse.nationalNumber,
        countryCode: parse.countryCode,
      );
    } on PlatformException {
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
