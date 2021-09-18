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
  IntColumn get checkListId => integer().customConstraint('REFERENCES checkLists(id)')();
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
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables:[CheckLists, Tasks], daos:[CheckListsDao, TasksDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  int get schemaVersion => 2;

  @override
  // implement migration
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if(from == 1){
        await migrator.createTable(tasks);
      }

    }
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


@UseDao(tables:[Tasks])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(AppDatabase db) : super(db);

  Future<List<Task>> getAllTasks () => select(tasks).get();
  Stream<List<Task>> watchAllTasks (){
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


}