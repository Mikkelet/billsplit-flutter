import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/domain/mappers/friends_mapper.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';

class ObserveFriendsUseCase {
  final _database = SplitsbyDatabase.instance;

  Stream<Iterable<Friend>> observe() {
    return _database.friendsDAO
        .watch()
        .map((event) => event.toFriends());
  }
}
