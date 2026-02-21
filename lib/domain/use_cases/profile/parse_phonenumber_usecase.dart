import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:flutter/services.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart' as pnp;

class ParsePhoneNumberUseCase {
  Future<PhoneNumber?> launch(String? phoneNumber) async {
    if (phoneNumber == null) return null;
    if (phoneNumber.isEmpty) return null;
    try {
      final parse = pnp.PhoneNumber.parse(phoneNumber);
      final countryCode =
          parse.countryCode.startsWith("+") ? parse.countryCode : "+${parse.countryCode}";
      return PhoneNumber(
        phoneNumber: parse.nsn,
        countryCode: countryCode,
      );
    } on PlatformException {
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
