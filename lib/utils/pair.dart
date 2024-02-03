class Pair<T, V> {
  final T first;
  final V second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return "Pair(first=$first, second=$second)";
  }
}