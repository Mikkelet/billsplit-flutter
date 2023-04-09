import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/friend_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/friend_status_dto.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';

extension FriendsDTOExt on Iterable<FriendDTO> {
  Iterable<Friend> toFriends() => map((e) => e.toFriend());

  Iterable<FriendDb> toDb() => map((e) => e.toDb());
}

extension FriendDTOExt on FriendDTO {
  FriendDb toDb() => FriendDb(id: id, friend: json.encode(this));

  Friend toFriend() {
    final FriendStatus friendStatus;
    if (status.typeClass is Accepted) {
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
