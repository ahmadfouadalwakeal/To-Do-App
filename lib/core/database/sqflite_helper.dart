import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/features/tasks/data/model/task_model.dart';

class SqfliteHelper {
  late Database db;
  //1.create Database
  //2.create table
  //3.crud=> create - read - update- delete

  //! init Db
  void initDb() async {
    // step1 => create Database
    await openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (db, version) async {
        // step2 => create Table
        await db.execute('''
            CREATE TABLE Tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            note TEXT,
            date TEXT,
            startTime TEXT,
            endTime TEXT,
            color INTEGER,
            isCompleted INTEGER)
        ''').then(
          (value) => print('DB created successfully'),
        );
      },
      onOpen: (db) => print('Database opened'),
    ).then((value) => db = value).catchError(
      (e) {
        e.toString();
      },
    );
  }

  //!get
  Future<List<Map<String, Object?>>> getFromDb() async {
    return await db.rawQuery('SELECT * FROM Tasks');
  }

  //!insert
  Future<int> insertToDb(TaskModel model) async {
    return await db.rawInsert('''
INSERT INTO Tasks(
title, note, date,startTime,endTime,color,isCompleted)
 VALUES(
 '${model.title}','${model.note}','${model.date}','${model.startTime}',
 '${model.endTime}','${model.color}','${model.isCompleted}')
 ''');
  }

  //!update
  Future<int> updateDp(int id) async {
    return await db.rawUpdate(
      '''
        UPDATE Tasks
        SET isCompleted = ?
        WHERE id = ?
        ''',
      [1, id],
    );
  }

  //!delete
  Future<int> deleteFromDB(int id) async {
    return await db.rawDelete(
      '''
        DELETE FROM Tasks
        WHERE id = ?
        ''',
      [id],
    );
  }
}
