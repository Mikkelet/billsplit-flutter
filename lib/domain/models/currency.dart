class Currency {
  final String _symbol;
  final num rate;

  Currency({required String symbol, required this.rate}) : _symbol = symbol;

  factory Currency.usd() => Currency(symbol: "usd", rate: 1);

  String get symbol => _symbol.toUpperCase();

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
