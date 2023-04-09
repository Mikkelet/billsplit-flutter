// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splitsby_db.dart';

// ignore_for_file: type=lint
class $GroupsTable extends Groups with TableInfo<$GroupsTable, GroupDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTable(this.attachedDatabase, [this._alias]);
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
  String get aliasedName => _alias ?? 'groups';
  @override
  String get actualTableName => 'groups';
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
  Set<GeneratedColumn> get $primaryKey => const {};
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
  $GroupsTable createAlias(String alias) {
    return $GroupsTable(attachedDatabase, alias);
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

  GroupsCompanion toCompanion(bool nullToAbsent) {
    return GroupsCompanion(
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

class GroupsCompanion extends UpdateCompanion<GroupDb> {
  final Value<String> groupId;
  final Value<String> group;
  final Value<int> rowid;
  const GroupsCompanion({
    this.groupId = const Value.absent(),
    this.group = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupsCompanion.insert({
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

  GroupsCompanion copyWith(
      {Value<String>? groupId, Value<String>? group, Value<int>? rowid}) {
    return GroupsCompanion(
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
    return (StringBuffer('GroupsCompanion(')
          ..write('groupId: $groupId, ')
          ..write('group: $group, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SplitsbyDatabase extends GeneratedDatabase {
  _$SplitsbyDatabase(QueryExecutor e) : super(e);
  late final $GroupsTable groups = $GroupsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [groups];
}
