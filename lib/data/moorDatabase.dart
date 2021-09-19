import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'moorDatabase.g.dart';

class CheckLists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get checkListName => text().withLength(min:1, max:50)();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get checkListId => integer()();
  TextColumn get toDo => text().withLength(min:1, max:100)();
  DateTimeColumn get createdAt => dateTime().nullable()();
  BoolColumn get isComplete => boolean().withDefault(Constant(false))();
}


LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite1'));
    return VmDatabase(file);
  });
}

@UseMoor(tables:[CheckLists, Tasks], daos:[CheckListsDao, TasksDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  int get schemaVersion => 6;

  @override
  // implement migration
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll(); // create all tables
      final TasksCompanion task = TasksCompanion.insert(checkListId: 1, toDo:'First'); 
      await into(tasks).insert(task); // insert on first run.
    },

    onUpgrade: (migrator, from, to) async {
      print('from version =====> $from');
      if(from == 5){
        await migrator.addColumn(tasks, tasks.checkListId);
      }
    },
  );
}

@UseDao(tables:[CheckLists])
class CheckListsDao extends DatabaseAccessor<AppDatabase> with _$CheckListsDaoMixin {

  CheckListsDao(AppDatabase db): super(db);

  Future<List<CheckList>> getAllChecklists () => select(checkLists).get(); //Selects the table and GETs all rows
  Stream<List<CheckList>> watchAllChecklists (){
    return (select(checkLists)
              // Statements like orderBy and where return void => the need to use a cascading ".." operator
              ..orderBy(
                ([
                  // Primary sorting by due date
                  (t) =>
                      OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
                  // Secondary alphabetical sorting
                  (t) => OrderingTerm(expression: t.checkListName),
                ]),
              ))
            // watch the whole select statement
            .watch();
  } //Table stream will emit any changes using this method
  Future insertCheckList(Insertable<CheckList>checkList) => into(checkLists).insert(checkList); //inserts an entity inside a table as a row
  Future deleteCheckList(Insertable<CheckList> checkList) => delete(checkLists).delete(checkList); //deletes the specified entity from table
  Future updateCheckList(Insertable<CheckList>checkList) => update(checkLists).replace(checkList); //updates given entity in table
  Future deleteAllCheckLists() => delete(checkLists).go();
}


@UseDao(tables:[Tasks, CheckLists])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(AppDatabase db) : super(db);

  Stream <List<Task>> watchTasksCustom (checkListId){
    return customSelect(
      'SELECT * FROM tasks WHERE check_list_id = ?',
      variables: [Variable.withInt(checkListId)],
      readsFrom: {tasks},
    ).watch().map(
      (rows)=> rows.map(
        (row){
          print('row.data =====> ${row.data}');
          return Task.fromData(row.data, db);
        }
      ).toList()
    );
  }

  Stream<List<Task>> watchAllTasks (checkListId) {
    return (
      select(tasks)
      ..orderBy(
        ([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          (t) => OrderingTerm(expression: t.toDo),
        ]),
      ))
      .watch();
  }

  Future insertTask(Insertable<Task> task){
    return into(tasks).insert(task);
  }

  Future updateTask(Insertable<Task> task) => update(tasks).replace(task);

}