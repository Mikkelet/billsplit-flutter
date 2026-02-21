import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../_generated/domain/models/subscription_service.freezed.dart';

@freezed
abstract class SubscriptionService with _$SubscriptionService {
  const factory SubscriptionService({
    @Default("") String id,
    @Default("") String name,
    @Default("") String currency,
    @Default("") String imageUrl,
    @Default(0) double monthlyExpense,
    @Default(Person()) Person createdBy,
    @Default(Person()) Person payer,
    @Default([]) List<Person> participants,
  }) = _SubscriptionService;

  const SubscriptionService._();

  factory SubscriptionService.newService({required Group group, required Person user}) =>
      SubscriptionService(
        id: "",
        name: "",
        createdBy: user,
        currency: group.defaultCurrency,
        payer: user,
        imageUrl: "",
        monthlyExpense: 0,
        participants: group.people.toList(),
      );
}
