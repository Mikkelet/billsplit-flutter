import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/friends_mapper.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

class RespondToFriendRequestUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch(Person person, bool accept) async {
    await _apiService.respondToFriendRequest(
        friendUid: person.uid, accept: accept);
    if (accept) {
      final acceptedFriend = Friend(person, FriendStatus.accepted).toDb();
      await _database.friendsDAO.insert(acceptedFriend);
    } else {
      final rejectedFriend = Friend(person, FriendStatus.requestReceived);
      await _database.friendsDAO.deleteFriend(rejectedFriend.toDb());
    }
  }
}
