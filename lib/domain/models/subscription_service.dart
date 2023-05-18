import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:collection/collection.dart';

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
  late num monthlyExpenseState = _monthlyExpense;
  late List<Person> participantsState = _participants.toList();
  late Person payerState = _payer;
  late String nameState = _name;
  late String currencyState = _currency;

  SubscriptionService(
      {required this.id,
      required String name,
      required String currency,
      required this.createdBy,
      required this.imageUrl,
      required num monthlyExpense,
      required Person payer,
      required Iterable<Person> participants})
      : _monthlyExpense = monthlyExpense,
        _participants = participants,
        _currency = currency,
        _payer = payer,
        _name = name;

  SubscriptionService.newService({required Group group, required Person user})
      : this(
            id: "",
            name: "",
            createdBy: user,
            currency: group.defaultCurrencyState,
            payer: user,
            imageUrl: "",
            monthlyExpense: 0,
            participants: group.people);

  bool get isChanged {
    return _name != nameState ||
        _monthlyExpense != monthlyExpenseState ||
        payerState != _payer ||
        currencyState != _currency ||
        !participantsState.equals(_participants.toList());
  }

  void resetChanges() {
    nameState = _name;
    monthlyExpenseState = _monthlyExpense;
    payerState = _payer;
    currencyState = _currency;
    participantsState = _participants.toList();
  }
}
