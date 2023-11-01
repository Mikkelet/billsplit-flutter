import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/friends_mapper.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:collection/collection.dart';

class ObserveFriendsUseCase {
  final _database = getIt<SplitsbyDatabase>();

  Stream<Iterable<Friend>> observe() {
    return _database.friendsDAO
        .watch()
        .map((event) => event.toFriends())
        .map((event) => event.sortedBy((element) => element.status.name));
  }
}
