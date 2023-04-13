import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

class SubscriptionService {
  final String id;
  final String _name;
  final Person createdBy;
  final String imageUrl;
  final num _monthlyExpense;
  final Person _payer;
  final List<Person> participants;

  // modifiable values
  late num monthlyExpenseState = _monthlyExpense;
  late Person payerState = _payer;
  late String nameState = _name;

  SubscriptionService(
      {required this.id,
      required String name,
      required this.createdBy,
      required this.imageUrl,
      required num monthlyExpense,
      required Person payer,
      required this.participants})
      : _monthlyExpense = monthlyExpense,
        _payer = payer,
        _name = name;

  SubscriptionService.newService({required Group group, required Person user})
      : this(
            id: "",
            name: "",
            createdBy: user,
            payer: user,
            imageUrl: "",
            monthlyExpense: 0,
            participants: group.people);
}
