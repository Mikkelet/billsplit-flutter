class PhoneNumber {
  final String phoneNumber;
  final String countryCode;

  PhoneNumber({required this.phoneNumber, required this.countryCode});

  const PhoneNumber.none()
      : phoneNumber = "",
        countryCode = "";

  String get display  => "$countryCode $phoneNumber";

  String get dial => "$countryCode$phoneNumber";

  @override
  String toString() {
    return "PhoneNumber(phoneNumber=$phoneNumber, countryCode=$countryCode)";
  }
}
