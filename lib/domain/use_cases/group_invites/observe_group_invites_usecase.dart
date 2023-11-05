import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/group_invites_mapper.dart';
import 'package:billsplit_flutter/domain/models/group_invite.dart';

class ObserveGroupInvitesUseCase {
  final _database = getIt<SplitsbyDatabase>();

  Stream<Iterable<GroupInvite>> observe() {
    return _database.groupInvitesDAO
        .watchGroups()
        .map((event) => event.map((e) => e.toGroupInvite()));
  }
}
