import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/presentation_data.dart';

class ObserveGroupsUseCase {
  final _database = getIt<SplitsbyDatabase>();

  Stream<Iterable<Group>> observe() {
    return Stream.value(presentationGroups);
    return _database.groupsDAO
        .watchGroups()
        .map((groupDbs) => groupDbs.toGroups());
  }
}
