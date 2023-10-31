import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:flutter/services.dart';
import 'package:phone_number/phone_number.dart' as phone_num_parser;

class ParsePhoneNumberUseCase {
  Future<PhoneNumber?> launch(String phoneNumber) async {
    if (phoneNumber.isEmpty) return null;
    try {
      final parse = await phone_num_parser.PhoneNumberUtil().parse(phoneNumber);
      final countryCode = parse.countryCode.startsWith("+") ? parse.countryCode : "+${parse.countryCode}";
      return PhoneNumber(
        phoneNumber: parse.nationalNumber,
        countryCode: countryCode,
      );
    } on PlatformException {
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
