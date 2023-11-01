import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/service_mapper.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';

class AddServiceUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch(String groupId, SubscriptionService service) async {
    if (service.id.isEmpty) {
      final responseServiceDto =
          await _apiService.addService(groupId, service.toDTO());
      await _database.servicesDao.insert(responseServiceDto.toDb(groupId));
    } else {
      await _apiService.updateService(groupId, service.toDTO());
      await _database.servicesDao.insert(service.toDTO().toDb(groupId));
    }
  }
}
