class Currency {
  final String symbol;
  final num rate;

  Currency({required this.symbol, required this.rate});

  factory Currency.USD() => Currency(symbol: "usd", rate: 1);
}
