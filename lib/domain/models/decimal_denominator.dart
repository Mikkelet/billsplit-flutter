enum DecimalDenominator {
  comma(decimal: ",", displayName: "comma"),
  period(decimal: ".", displayName: "period");

  final String decimal;
  final String displayName;

  const DecimalDenominator({
    required this.decimal,
    required this.displayName,
  });

  static DecimalDenominator fromString(String value) {
    if (value == DecimalDenominator.comma.displayName) {
      return DecimalDenominator.comma;
    }
    return DecimalDenominator.period;
  }
}
