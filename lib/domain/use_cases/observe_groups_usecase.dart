import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

class ObserveGroupsUseCase {
  final _database = SplitsbyDatabase.instance;

  Stream<List<Group>> observe() {
    return _database.watchGroups().map((event) => event.toGroups());
  }
}
