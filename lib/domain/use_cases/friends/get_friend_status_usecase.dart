import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/friends_mapper.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';

class GetFriendStatusUseCase {
  final _database = getIt<SplitsbyDatabase>();
  final _authRepository = getIt<AuthRepository>();

  Future<FriendStatus> launch(String friendUid) async {
    if (friendUid == _authRepository.loggedInUser.uid) {
      return FriendStatus.accepted;
    }
    final response = await _database.friendsDAO.getFriend(friendUid);
    if (response == null) return FriendStatus.notFriends;
    final friend = response.toFriend();
    return friend.status;
  }
}
