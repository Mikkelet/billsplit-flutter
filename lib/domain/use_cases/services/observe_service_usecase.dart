import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/service_mapper.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';

class ObserveServiceUseCase {
  final _database = getIt<SplitsbyDatabase>();

  Stream<SubscriptionService> observe(String groupId, String serviceId) async* {
    await for (final services in _database.servicesDao.watch(groupId)) {
      for (final service in services) {
        if (service.id == serviceId) yield service.toService();
      }
    }
  }
}
