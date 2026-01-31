import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

class SubscriptionService {
  final String id;
  final String _name;
  final num _monthlyExpense;
  final String _currency;
  final Person createdBy;
  final String imageUrl;
  final Person _payer;
  final Iterable<Person> _participants;

  // modifiable values
  late final MutableState<num> monthlyExpenseState = _monthlyExpense.obs();
  late final MutableListState<Person> participantsState = _participants.obsList();
  late final MutableState<Person> payerState = _payer.obs();
  late final MutableState<String> nameState = _name.obs();
  late final MutableState<String> currencyState = _currency.obs();

  SubscriptionService({
    required this.id,
    required String name,
    required String currency,
    required this.createdBy,
    required this.imageUrl,
    required num monthlyExpense,
    required Person payer,
    required Iterable<Person> participants,
  })  : _monthlyExpense = monthlyExpense,
        _participants = participants,
        _currency = currency,
        _payer = payer,
        _name = name;

  SubscriptionService.newService({required Group group, required Person user})
      : this(
          id: "",
          name: "",
          createdBy: user,
          currency: group.defaultCurrencyState.value,
          payer: user,
          imageUrl: "",
          monthlyExpense: 0,
          participants: group.peopleState.value,
        );

  bool get isChanged {
    return _name != nameState.value ||
        _monthlyExpense != monthlyExpenseState.value ||
        payerState.value != _payer ||
        currencyState.value != _currency ||
        !participantsState.value.toList().equals(_participants.toList());
  }

  Stream<bool> get isChangedStream {
    final streams = [
      nameState.stateStream.map((name) => name != _name),
      monthlyExpenseState.stateStream
          .map((expense) => expense != _monthlyExpense),
      payerState.stateStream.map((payer) => payer != _payer),
      currencyState.stateStream.map((currency) => currency != _currency),
      participantsState.stateStream.map((participants) =>
          !participants.toList().equals(_participants.toList()))
    ];
    return CombineLatestStream(
        streams, (values) => values.any((isChanged) => isChanged));
  }

  void resetChanges() {
    nameState.value = _name;
    monthlyExpenseState.value = _monthlyExpense;
    payerState.value = _payer;
    currencyState.value = _currency;
    participantsState.value = _participants.toList();
  }
}
