import 'package:billsplit_flutter/domain/models/person.dart';

class SubscriptionService {
  final String id;
  final String name;
  final Person createdBy;
  final String imageUrl;
  final num monthlyExpense;
  final Person payer;
  final List<Person> participants;

  SubscriptionService(
      {required this.id,
      required this.name,
      required this.createdBy,
      required this.imageUrl,
      required this.monthlyExpense,
      required this.payer,
      required this.participants});
}

/**
 * data class SubscriptionService(
    val id: String,
    private val name: String,
    val createdBy: Person,
    val imageUrl: String,
    private val monthlyExpense: Float,
    private val payer: Person,
    private val participants: List<Person>
    ) {
 */