enum SurchargeType {
  fixed,
  percentage;
}

class Surcharge {
  final String name;
  final SurchargeType type;
  final num value;

  Surcharge({required this.name, required this.type, required this.value});
}
