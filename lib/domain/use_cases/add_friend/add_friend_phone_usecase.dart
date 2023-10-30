import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/friends_mapper.dart';

class AddFriendPhoneUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch(String phone) async {
    final response = await _apiService.addFriendPhone(phone);
    _database.friendsDAO.insert(response.toDb());
  }
}
