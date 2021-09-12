// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moorDatabase.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CheckList extends DataClass implements Insertable<CheckList> {
  final int id;
  final String checkListName;
  final DateTime? createdAt;
  CheckList({required this.id, required this.checkListName, this.createdAt});
  factory CheckList.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CheckList(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      checkListName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}check_list_name'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['check_list_name'] = Variable<String>(checkListName);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime?>(createdAt);
    }
    return map;
  }

  CheckListsCompanion toCompanion(bool nullToAbsent) {
    return CheckListsCompanion(
      id: Value(id),
      checkListName: Value(checkListName),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory CheckList.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CheckList(
      id: serializer.fromJson<int>(json['id']),
      checkListName: serializer.fromJson<String>(json['checkListName']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'checkListName': serializer.toJson<String>(checkListName),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  CheckList copyWith({int? id, String? checkListName, DateTime? createdAt}) =>
      CheckList(
        id: id ?? this.id,
        checkListName: checkListName ?? this.checkListName,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('CheckList(')
          ..write('id: $id, ')
          ..write('checkListName: $checkListName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(id.hashCode, $mrjc(checkListName.hashCode, createdAt.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckList &&
          other.id == this.id &&
          other.checkListName == this.checkListName &&
          other.createdAt == this.createdAt);
}

class CheckListsCompanion extends UpdateCompanion<CheckList> {
  final Value<int> id;
  final Value<String> checkListName;
  final Value<DateTime?> createdAt;
  const CheckListsCompanion({
    this.id = const Value.absent(),
    this.checkListName = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CheckListsCompanion.insert({
    this.id = const Value.absent(),
    required String checkListName,
    this.createdAt = const Value.absent(),
  }) : checkListName = Value(checkListName);
  static Insertable<CheckList> custom({
    Expression<int>? id,
    Expression<String>? checkListName,
    Expression<DateTime?>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkListName != null) 'check_list_name': checkListName,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CheckListsCompanion copyWith(
      {Value<int>? id,
      Value<String>? checkListName,
      Value<DateTime?>? createdAt}) {
    return CheckListsCompanion(
      id: id ?? this.id,
      checkListName: checkListName ?? this.checkListName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (checkListName.present) {
      map['check_list_name'] = Variable<String>(checkListName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime?>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckListsCompanion(')
          ..write('id: $id, ')
          ..write('checkListName: $checkListName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CheckListsTable extends CheckLists
    with TableInfo<$CheckListsTable, CheckList> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CheckListsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _checkListNameMeta =
      const VerificationMeta('checkListName');
  late final GeneratedColumn<String?> checkListName = GeneratedColumn<String?>(
      'check_list_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, checkListName, createdAt];
  @override
  String get aliasedName => _alias ?? 'check_lists';
  @override
  String get actualTableName => 'check_lists';
  @override
  VerificationContext validateIntegrity(Insertable<CheckList> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('check_list_name')) {
      context.handle(
          _checkListNameMeta,
          checkListName.isAcceptableOrUnknown(
              data['check_list_name']!, _checkListNameMeta));
    } else if (isInserting) {
      context.missing(_checkListNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckList map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CheckList.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CheckListsTable createAlias(String alias) {
    return $CheckListsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CheckListsTable checkLists = $CheckListsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [checkLists];
}
