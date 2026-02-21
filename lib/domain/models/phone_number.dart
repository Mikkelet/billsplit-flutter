import 'package:freezed_annotation/freezed_annotation.dart';

part '../../_generated/domain/models/phone_number.freezed.dart';

@freezed
abstract class PhoneNumber with _$PhoneNumber {
  const factory PhoneNumber({
    @Default("") String phoneNumber,
    @Default("") String countryCode,
  }) = _PhoneNumber;

  const PhoneNumber._();

  String get display  => "$countryCode $phoneNumber";

  String get dial => "$countryCode$phoneNumber";
}