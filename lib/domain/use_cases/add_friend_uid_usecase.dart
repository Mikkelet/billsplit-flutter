import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/friends_mapper.dart';

class AddFriendUserIdUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  AddFriendUserIdUseCase();

  Future launch(String userId) async {
    final response = await _apiService.addFriendUserId(userId);
    _database.friendsDAO.insert(response.toDb());
  }

}
