enum DecimalDenominator {
  comma(",", ".", "comma"),
  period(".", ",", "period");

  final String symbol;
  final String displayName;
  final String thousandsSeparator;

  const DecimalDenominator(
    this.symbol,
    this.thousandsSeparator,
    this.displayName,
  );

  static DecimalDenominator fromString(String value) {
    if (value == DecimalDenominator.comma.displayName) {
      return DecimalDenominator.comma;
    }
    return DecimalDenominator.period;
  }
}
