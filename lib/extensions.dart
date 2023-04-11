import 'domain/models/individual_expense.dart';

extension IterableExt<T> on Iterable<T> {
  List<T> toImmutableList() {
    return toList(growable: false);
  }
}

extension ListExt<T, V> on List<T> {
  List<V> mapToImmutableList(V Function(T) toElement) {
    return map((e) => toElement(e)).toImmutableList();
  }
}

extension Sum on List<IndividualExpense> {
  num sumExpenses() {
    return map((e) => e.expense).reduce((value, element) => value += element);
  }
}

extension MapExt<T> on Iterable<Iterable<T>> {
  Iterable<T> flatMap() {
    return fold([], (previousValue, element) => [...previousValue, ...element]);
  }
}

typedef Json = Map<String, dynamic>;

T builder<T>(T Function() build) => build();