class Currency {
  final String symbol;
  final num rate;

  Currency({required this.symbol, required this.rate});

  factory Currency.USD() => Currency(symbol: "usd", rate: 1);

  @override
  bool operator ==(Object other) {
    if (other is! Currency) return false;
    return symbol.toLowerCase() == other.symbol.toLowerCase();
  }

  @override
  String toString() {
    return "Currency(symbol=$symbol, rate=$rate)";
  }
}
