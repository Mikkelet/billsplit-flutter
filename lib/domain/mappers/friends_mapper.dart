import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/friend_dto.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';

extension FriendsDTOExt on Iterable<FriendDTO> {
  Iterable<Friend> toFriends() => map((e) => e.toFriend());

  Iterable<FriendDb> toDb() => map((e) => e.toDb());
}

extension FriendDTOExt on FriendDTO {
  FriendDb toDb() => FriendDb(
      uid: friend.id,
      friend: json.encode(this),
      status: status,
      createdBy: createdBy);

  Friend toFriend() {
    final FriendStatus friendStatus;
    if (status == FriendDTO.statusAccepted) {
      friendStatus = FriendStatus.accepted;
    } else if (createdBy == friend.id) {
      friendStatus = FriendStatus.requestReceived;
    } else {
      friendStatus = FriendStatus.requestSent;
    }
    return Friend(friend.toPerson(), friendStatus);
  }
}

extension FriendsDbExt on Iterable<FriendDb> {
  Iterable<FriendDTO> toDto() => map((e) => e.toDto());

  Iterable<Friend> toFriends() => map((e) => e.toFriend());
}

extension FriendDbExt on FriendDb {
  FriendDTO toDto() => FriendDTO.fromJson(json.decode(friend));

  Friend toFriend() => toDto().toFriend();
}

extension FriendExt on Friend {
  FriendDb toDb() => FriendDb(
      uid: person.uid,
      friend: json.encode(person.toDTO().toJson()),
      status: status.dbValue,
      createdBy: person.uid);
}
