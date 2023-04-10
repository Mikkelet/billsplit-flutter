import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/friends_mapper.dart';

class GetFriendsUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch() async {
    final response = await _apiService.getFriends();
    final friendsDb = response.friends.toDb();
    await _database.friendsDAO.insertAll(friendsDb);
  }
}
