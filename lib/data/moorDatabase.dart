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

@UseMoor(tables:[CheckLists])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());


  int get schemaVersion => 1;
  
  //Below we will create query methods for this class
  Future<List<CheckList>> getAllChecklists () => select(checkLists).get(); //Selects the table and GETs all rows
  Stream<List<CheckList>> watchAllChecklists () => select(checkLists).watch(); //Table stream will emit any changes using this method
  Future insertCheckList(checkList) => into(checkLists).insert(checkList); //inserts an entity inside a table as a row
  Future deleteCheckList(CheckList checkList) => delete(checkLists).delete(checkList); //deletes the specified entity from table
  Future updateCheckList(CheckList checkList) => update(checkLists).replace(checkList); //updates given entity in table
  Future deleteAllCheckLists() => delete(checkLists).go();
}