import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';

class DeleteServiceUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch(String groupId, SubscriptionService service) async {
    await _apiService.deleteService(groupId, service.id);
    await _database.servicesDao.deleteService(service.id);
  }
}
