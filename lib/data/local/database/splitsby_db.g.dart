// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splitsby_db.dart';

// ignore_for_file: type=lint
class $GroupsTableTable extends GroupsTable
    with TableInfo<$GroupsTableTable, GroupDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _groupMeta = const VerificationMeta('group');
  @override
  late final GeneratedColumn<String> group = GeneratedColumn<String>(
      'group', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [groupId, group];
  @override
  String get aliasedName => _alias ?? 'groups_table';
  @override
  String get actualTableName => 'groups_table';
  @override
  VerificationContext validateIntegrity(Insertable<GroupDb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('group')) {
      context.handle(
          _groupMeta, group.isAcceptableOrUnknown(data['group']!, _groupMeta));
    } else if (isInserting) {
      context.missing(_groupMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {groupId, group};
  @override
  GroupDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupDb(
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      group: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group'])!,
    );
  }

  @override
  $GroupsTableTable createAlias(String alias) {
    return $GroupsTableTable(attachedDatabase, alias);
  }
}

class GroupDb extends DataClass implements Insertable<GroupDb> {
  final String groupId;
  final String group;
  const GroupDb({required this.groupId, required this.group});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['group_id'] = Variable<String>(groupId);
    map['group'] = Variable<String>(group);
    return map;
  }

  GroupsTableCompanion toCompanion(bool nullToAbsent) {
    return GroupsTableCompanion(
      groupId: Value(groupId),
      group: Value(group),
    );
  }

  factory GroupDb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupDb(
      groupId: serializer.fromJson<String>(json['groupId']),
      group: serializer.fromJson<String>(json['group']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'groupId': serializer.toJson<String>(groupId),
      'group': serializer.toJson<String>(group),
    };
  }

  GroupDb copyWith({String? groupId, String? group}) => GroupDb(
        groupId: groupId ?? this.groupId,
        group: group ?? this.group,
      );
  @override
  String toString() {
    return (StringBuffer('GroupDb(')
          ..write('groupId: $groupId, ')
          ..write('group: $group')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(groupId, group);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupDb &&
          other.groupId == this.groupId &&
          other.group == this.group);
}

class GroupsTableCompanion extends UpdateCompanion<GroupDb> {
  final Value<String> groupId;
  final Value<String> group;
  final Value<int> rowid;
  const GroupsTableCompanion({
    this.groupId = const Value.absent(),
    this.group = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupsTableCompanion.insert({
    required String groupId,
    required String group,
    this.rowid = const Value.absent(),
  })  : groupId = Value(groupId),
        group = Value(group);
  static Insertable<GroupDb> custom({
    Expression<String>? groupId,
    Expression<String>? group,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (groupId != null) 'group_id': groupId,
      if (group != null) 'group': group,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupsTableCompanion copyWith(
      {Value<String>? groupId, Value<String>? group, Value<int>? rowid}) {
    return GroupsTableCompanion(
      groupId: groupId ?? this.groupId,
      group: group ?? this.group,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (group.present) {
      map['group'] = Variable<String>(group.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsTableCompanion(')
          ..write('groupId: $groupId, ')
          ..write('group: $group, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupExpenseTableTable extends GroupExpenseTable
    with TableInfo<$GroupExpenseTableTable, GroupExpenseDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupExpenseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupExpenseMeta =
      const VerificationMeta('groupExpense');
  @override
  late final GeneratedColumn<String> groupExpense = GeneratedColumn<String>(
      'group_expense', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<int> syncState = GeneratedColumn<int>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, groupId, groupExpense, syncState];
  @override
  String get aliasedName => _alias ?? 'group_expense_table';
  @override
  String get actualTableName => 'group_expense_table';
  @override
  VerificationContext validateIntegrity(Insertable<GroupExpenseDb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('group_expense')) {
      context.handle(
          _groupExpenseMeta,
          groupExpense.isAcceptableOrUnknown(
              data['group_expense']!, _groupExpenseMeta));
    } else if (isInserting) {
      context.missing(_groupExpenseMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    } else if (isInserting) {
      context.missing(_syncStateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  GroupExpenseDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupExpenseDb(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      groupExpense: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_expense'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_state'])!,
    );
  }

  @override
  $GroupExpenseTableTable createAlias(String alias) {
    return $GroupExpenseTableTable(attachedDatabase, alias);
  }
}

class GroupExpenseDb extends DataClass implements Insertable<GroupExpenseDb> {
  final String id;
  final String groupId;
  final String groupExpense;
  final int syncState;
  const GroupExpenseDb(
      {required this.id,
      required this.groupId,
      required this.groupExpense,
      required this.syncState});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['group_expense'] = Variable<String>(groupExpense);
    map['sync_state'] = Variable<int>(syncState);
    return map;
  }

  GroupExpenseTableCompanion toCompanion(bool nullToAbsent) {
    return GroupExpenseTableCompanion(
      id: Value(id),
      groupId: Value(groupId),
      groupExpense: Value(groupExpense),
      syncState: Value(syncState),
    );
  }

  factory GroupExpenseDb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupExpenseDb(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      groupExpense: serializer.fromJson<String>(json['groupExpense']),
      syncState: serializer.fromJson<int>(json['syncState']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'groupExpense': serializer.toJson<String>(groupExpense),
      'syncState': serializer.toJson<int>(syncState),
    };
  }

  GroupExpenseDb copyWith(
          {String? id,
          String? groupId,
          String? groupExpense,
          int? syncState}) =>
      GroupExpenseDb(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        groupExpense: groupExpense ?? this.groupExpense,
        syncState: syncState ?? this.syncState,
      );
  @override
  String toString() {
    return (StringBuffer('GroupExpenseDb(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('groupExpense: $groupExpense, ')
          ..write('syncState: $syncState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, groupExpense, syncState);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupExpenseDb &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.groupExpense == this.groupExpense &&
          other.syncState == this.syncState);
}

class GroupExpenseTableCompanion extends UpdateCompanion<GroupExpenseDb> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> groupExpense;
  final Value<int> syncState;
  final Value<int> rowid;
  const GroupExpenseTableCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.groupExpense = const Value.absent(),
    this.syncState = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupExpenseTableCompanion.insert({
    required String id,
    required String groupId,
    required String groupExpense,
    required int syncState,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupId = Value(groupId),
        groupExpense = Value(groupExpense),
        syncState = Value(syncState);
  static Insertable<GroupExpenseDb> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? groupExpense,
    Expression<int>? syncState,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (groupExpense != null) 'group_expense': groupExpense,
      if (syncState != null) 'sync_state': syncState,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupExpenseTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? groupExpense,
      Value<int>? syncState,
      Value<int>? rowid}) {
    return GroupExpenseTableCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      groupExpense: groupExpense ?? this.groupExpense,
      syncState: syncState ?? this.syncState,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (groupExpense.present) {
      map['group_expense'] = Variable<String>(groupExpense.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<int>(syncState.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupExpenseTableCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('groupExpense: $groupExpense, ')
          ..write('syncState: $syncState, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FriendsTableTable extends FriendsTable
    with TableInfo<$FriendsTableTable, FriendDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _friendMeta = const VerificationMeta('friend');
  @override
  late final GeneratedColumn<String> friend = GeneratedColumn<String>(
      'friend', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, friend];
  @override
  String get aliasedName => _alias ?? 'friends_table';
  @override
  String get actualTableName => 'friends_table';
  @override
  VerificationContext validateIntegrity(Insertable<FriendDb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('friend')) {
      context.handle(_friendMeta,
          friend.isAcceptableOrUnknown(data['friend']!, _friendMeta));
    } else if (isInserting) {
      context.missing(_friendMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FriendDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendDb(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      friend: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}friend'])!,
    );
  }

  @override
  $FriendsTableTable createAlias(String alias) {
    return $FriendsTableTable(attachedDatabase, alias);
  }
}

class FriendDb extends DataClass implements Insertable<FriendDb> {
  final String id;
  final String friend;
  const FriendDb({required this.id, required this.friend});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['friend'] = Variable<String>(friend);
    return map;
  }

  FriendsTableCompanion toCompanion(bool nullToAbsent) {
    return FriendsTableCompanion(
      id: Value(id),
      friend: Value(friend),
    );
  }

  factory FriendDb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendDb(
      id: serializer.fromJson<String>(json['id']),
      friend: serializer.fromJson<String>(json['friend']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'friend': serializer.toJson<String>(friend),
    };
  }

  FriendDb copyWith({String? id, String? friend}) => FriendDb(
        id: id ?? this.id,
        friend: friend ?? this.friend,
      );
  @override
  String toString() {
    return (StringBuffer('FriendDb(')
          ..write('id: $id, ')
          ..write('friend: $friend')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, friend);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendDb && other.id == this.id && other.friend == this.friend);
}

class FriendsTableCompanion extends UpdateCompanion<FriendDb> {
  final Value<String> id;
  final Value<String> friend;
  final Value<int> rowid;
  const FriendsTableCompanion({
    this.id = const Value.absent(),
    this.friend = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendsTableCompanion.insert({
    required String id,
    required String friend,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        friend = Value(friend);
  static Insertable<FriendDb> custom({
    Expression<String>? id,
    Expression<String>? friend,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (friend != null) 'friend': friend,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendsTableCompanion copyWith(
      {Value<String>? id, Value<String>? friend, Value<int>? rowid}) {
    return FriendsTableCompanion(
      id: id ?? this.id,
      friend: friend ?? this.friend,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (friend.present) {
      map['friend'] = Variable<String>(friend.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendsTableCompanion(')
          ..write('id: $id, ')
          ..write('friend: $friend, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServicesTableTable extends ServicesTable
    with TableInfo<$ServicesTableTable, ServiceDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serviceMeta =
      const VerificationMeta('service');
  @override
  late final GeneratedColumn<String> service = GeneratedColumn<String>(
      'service', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, groupId, service];
  @override
  String get aliasedName => _alias ?? 'services_table';
  @override
  String get actualTableName => 'services_table';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceDb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('service')) {
      context.handle(_serviceMeta,
          service.isAcceptableOrUnknown(data['service']!, _serviceMeta));
    } else if (isInserting) {
      context.missing(_serviceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ServiceDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceDb(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      service: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service'])!,
    );
  }

  @override
  $ServicesTableTable createAlias(String alias) {
    return $ServicesTableTable(attachedDatabase, alias);
  }
}

class ServiceDb extends DataClass implements Insertable<ServiceDb> {
  final String id;
  final String groupId;
  final String service;
  const ServiceDb(
      {required this.id, required this.groupId, required this.service});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['service'] = Variable<String>(service);
    return map;
  }

  ServicesTableCompanion toCompanion(bool nullToAbsent) {
    return ServicesTableCompanion(
      id: Value(id),
      groupId: Value(groupId),
      service: Value(service),
    );
  }

  factory ServiceDb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceDb(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      service: serializer.fromJson<String>(json['service']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'service': serializer.toJson<String>(service),
    };
  }

  ServiceDb copyWith({String? id, String? groupId, String? service}) =>
      ServiceDb(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        service: service ?? this.service,
      );
  @override
  String toString() {
    return (StringBuffer('ServiceDb(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('service: $service')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, service);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceDb &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.service == this.service);
}

class ServicesTableCompanion extends UpdateCompanion<ServiceDb> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> service;
  final Value<int> rowid;
  const ServicesTableCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.service = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServicesTableCompanion.insert({
    required String id,
    required String groupId,
    required String service,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupId = Value(groupId),
        service = Value(service);
  static Insertable<ServiceDb> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? service,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (service != null) 'service': service,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServicesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? service,
      Value<int>? rowid}) {
    return ServicesTableCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      service: service ?? this.service,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (service.present) {
      map['service'] = Variable<String>(service.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesTableCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('service: $service, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTableTable extends PaymentsTable
    with TableInfo<$PaymentsTableTable, PaymentDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentMeta =
      const VerificationMeta('payment');
  @override
  late final GeneratedColumn<String> payment = GeneratedColumn<String>(
      'payment', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, groupId, payment];
  @override
  String get aliasedName => _alias ?? 'payments_table';
  @override
  String get actualTableName => 'payments_table';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentDb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('payment')) {
      context.handle(_paymentMeta,
          payment.isAcceptableOrUnknown(data['payment']!, _paymentMeta));
    } else if (isInserting) {
      context.missing(_paymentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PaymentDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentDb(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      payment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment'])!,
    );
  }

  @override
  $PaymentsTableTable createAlias(String alias) {
    return $PaymentsTableTable(attachedDatabase, alias);
  }
}

class PaymentDb extends DataClass implements Insertable<PaymentDb> {
  final String id;
  final String groupId;
  final String payment;
  const PaymentDb(
      {required this.id, required this.groupId, required this.payment});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['payment'] = Variable<String>(payment);
    return map;
  }

  PaymentsTableCompanion toCompanion(bool nullToAbsent) {
    return PaymentsTableCompanion(
      id: Value(id),
      groupId: Value(groupId),
      payment: Value(payment),
    );
  }

  factory PaymentDb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentDb(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      payment: serializer.fromJson<String>(json['payment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'payment': serializer.toJson<String>(payment),
    };
  }

  PaymentDb copyWith({String? id, String? groupId, String? payment}) =>
      PaymentDb(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        payment: payment ?? this.payment,
      );
  @override
  String toString() {
    return (StringBuffer('PaymentDb(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('payment: $payment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, payment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentDb &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.payment == this.payment);
}

class PaymentsTableCompanion extends UpdateCompanion<PaymentDb> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> payment;
  final Value<int> rowid;
  const PaymentsTableCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.payment = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsTableCompanion.insert({
    required String id,
    required String groupId,
    required String payment,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupId = Value(groupId),
        payment = Value(payment);
  static Insertable<PaymentDb> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? payment,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (payment != null) 'payment': payment,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? payment,
      Value<int>? rowid}) {
    return PaymentsTableCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      payment: payment ?? this.payment,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (payment.present) {
      map['payment'] = Variable<String>(payment.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTableCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('payment: $payment, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SplitsbyDatabase extends GeneratedDatabase {
  _$SplitsbyDatabase(QueryExecutor e) : super(e);
  late final $GroupsTableTable groupsTable = $GroupsTableTable(this);
  late final $GroupExpenseTableTable groupExpenseTable =
      $GroupExpenseTableTable(this);
  late final $FriendsTableTable friendsTable = $FriendsTableTable(this);
  late final $ServicesTableTable servicesTable = $ServicesTableTable(this);
  late final $PaymentsTableTable paymentsTable = $PaymentsTableTable(this);
  late final GroupsDAO groupsDAO = GroupsDAO(this as SplitsbyDatabase);
  late final GroupExpenseDAO groupExpenseDAO =
      GroupExpenseDAO(this as SplitsbyDatabase);
  late final ServicesDao servicesDao = ServicesDao(this as SplitsbyDatabase);
  late final FriendsDAO friendsDAO = FriendsDAO(this as SplitsbyDatabase);
  late final PaymentsDAO paymentsDAO = PaymentsDAO(this as SplitsbyDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        groupsTable,
        groupExpenseTable,
        friendsTable,
        servicesTable,
        paymentsTable
      ];
}
