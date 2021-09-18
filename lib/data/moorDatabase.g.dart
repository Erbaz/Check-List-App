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

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final int checkListId;
  final String toDo;
  final DateTime? createdAt;
  final bool isComplete;
  Task(
      {required this.id,
      required this.checkListId,
      required this.toDo,
      this.createdAt,
      required this.isComplete});
  factory Task.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Task(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      checkListId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}check_list_id'])!,
      toDo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}to_do'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      isComplete: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_complete'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['check_list_id'] = Variable<int>(checkListId);
    map['to_do'] = Variable<String>(toDo);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime?>(createdAt);
    }
    map['is_complete'] = Variable<bool>(isComplete);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      checkListId: Value(checkListId),
      toDo: Value(toDo),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      isComplete: Value(isComplete),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      checkListId: serializer.fromJson<int>(json['checkListId']),
      toDo: serializer.fromJson<String>(json['toDo']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      isComplete: serializer.fromJson<bool>(json['isComplete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'checkListId': serializer.toJson<int>(checkListId),
      'toDo': serializer.toJson<String>(toDo),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'isComplete': serializer.toJson<bool>(isComplete),
    };
  }

  Task copyWith(
          {int? id,
          int? checkListId,
          String? toDo,
          DateTime? createdAt,
          bool? isComplete}) =>
      Task(
        id: id ?? this.id,
        checkListId: checkListId ?? this.checkListId,
        toDo: toDo ?? this.toDo,
        createdAt: createdAt ?? this.createdAt,
        isComplete: isComplete ?? this.isComplete,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('checkListId: $checkListId, ')
          ..write('toDo: $toDo, ')
          ..write('createdAt: $createdAt, ')
          ..write('isComplete: $isComplete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          checkListId.hashCode,
          $mrjc(
              toDo.hashCode, $mrjc(createdAt.hashCode, isComplete.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.checkListId == this.checkListId &&
          other.toDo == this.toDo &&
          other.createdAt == this.createdAt &&
          other.isComplete == this.isComplete);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<int> checkListId;
  final Value<String> toDo;
  final Value<DateTime?> createdAt;
  final Value<bool> isComplete;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.checkListId = const Value.absent(),
    this.toDo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isComplete = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required int checkListId,
    required String toDo,
    this.createdAt = const Value.absent(),
    this.isComplete = const Value.absent(),
  })  : checkListId = Value(checkListId),
        toDo = Value(toDo);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<int>? checkListId,
    Expression<String>? toDo,
    Expression<DateTime?>? createdAt,
    Expression<bool>? isComplete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checkListId != null) 'check_list_id': checkListId,
      if (toDo != null) 'to_do': toDo,
      if (createdAt != null) 'created_at': createdAt,
      if (isComplete != null) 'is_complete': isComplete,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<int>? checkListId,
      Value<String>? toDo,
      Value<DateTime?>? createdAt,
      Value<bool>? isComplete}) {
    return TasksCompanion(
      id: id ?? this.id,
      checkListId: checkListId ?? this.checkListId,
      toDo: toDo ?? this.toDo,
      createdAt: createdAt ?? this.createdAt,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (checkListId.present) {
      map['check_list_id'] = Variable<int>(checkListId.value);
    }
    if (toDo.present) {
      map['to_do'] = Variable<String>(toDo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime?>(createdAt.value);
    }
    if (isComplete.present) {
      map['is_complete'] = Variable<bool>(isComplete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('checkListId: $checkListId, ')
          ..write('toDo: $toDo, ')
          ..write('createdAt: $createdAt, ')
          ..write('isComplete: $isComplete')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _checkListIdMeta =
      const VerificationMeta('checkListId');
  late final GeneratedColumn<int?> checkListId = GeneratedColumn<int?>(
      'check_list_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES checkLists(id)');
  final VerificationMeta _toDoMeta = const VerificationMeta('toDo');
  late final GeneratedColumn<String?> toDo = GeneratedColumn<String?>(
      'to_do', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _isCompleteMeta = const VerificationMeta('isComplete');
  late final GeneratedColumn<bool?> isComplete = GeneratedColumn<bool?>(
      'is_complete', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_complete IN (0, 1))',
      defaultValue: Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, checkListId, toDo, createdAt, isComplete];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('check_list_id')) {
      context.handle(
          _checkListIdMeta,
          checkListId.isAcceptableOrUnknown(
              data['check_list_id']!, _checkListIdMeta));
    } else if (isInserting) {
      context.missing(_checkListIdMeta);
    }
    if (data.containsKey('to_do')) {
      context.handle(
          _toDoMeta, toDo.isAcceptableOrUnknown(data['to_do']!, _toDoMeta));
    } else if (isInserting) {
      context.missing(_toDoMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_complete')) {
      context.handle(
          _isCompleteMeta,
          isComplete.isAcceptableOrUnknown(
              data['is_complete']!, _isCompleteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Task.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CheckListsTable checkLists = $CheckListsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final CheckListsDao checkListsDao = CheckListsDao(this as AppDatabase);
  late final TasksDao tasksDao = TasksDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [checkLists, tasks];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$CheckListsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CheckListsTable get checkLists => attachedDatabase.checkLists;
}
mixin _$TasksDaoMixin on DatabaseAccessor<AppDatabase> {
  $TasksTable get tasks => attachedDatabase.tasks;
}
