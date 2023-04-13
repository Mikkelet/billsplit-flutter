import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

class SubscriptionService {
  final String id;
  final String name;
  final Person createdBy;
  final String imageUrl;
  final num _monthlyExpense;
  final Person payer;
  final List<Person> participants;

  // modifiable values
  late num monthlyExpenseState = _monthlyExpense;

  SubscriptionService(
      {required this.id,
      required this.name,
      required this.createdBy,
      required this.imageUrl,
      required num monthlyExpense,
      required this.payer,
      required this.participants})
      : _monthlyExpense = monthlyExpense;

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
