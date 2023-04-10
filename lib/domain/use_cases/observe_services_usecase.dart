import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/service_mapper.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';

class ObserveServicesUseCase {
  final _database = getIt<SplitsbyDatabase>();

  Stream<Iterable<SubscriptionService>> observe(String groupId) {
    return _database.servicesDao
        .watch(groupId)
        .map((event) => event.toServices());
  }
}
