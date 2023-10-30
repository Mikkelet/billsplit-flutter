class PhoneNumber {
  final String phoneNumber;
  final String countryCode;

  PhoneNumber({required this.phoneNumber, required this.countryCode});

  PhoneNumber.none()
      : phoneNumber = "",
        countryCode = "";

  String get display  => "+$countryCode $phoneNumber";
}
