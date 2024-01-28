import 'dart:io';

import 'package:sqflite/sqflite.dart';

import 'dataClass.dart';

class DbHelper {
  static Database? db;
  static String databasesPath = '';
  static String dbFilePath = '';
  static bool dbExists = false;
  static bool tableExists = false;
  static const dbFileName = 'my_dbase.db';
  static const tableName = 'data';

  static Future<void> initialize() async {
    print('started initialization');
    databasesPath = await getDatabasesPath();
    dbFilePath = '$databasesPath/$dbFileName';
    await openDatabaseFunc();
  }

  // ////////////////////////////////////////////////////////////////////////////////
  static Future<void> openDatabaseFunc() async {
    db = await openDatabase(dbFileName).then((value) {
      if (value.isOpen == true) {
        dbExists = true;
        print('finished initialization');
      }
      return value;
    }).catchError((err) {
      throw Exception('$err \n Error initializing database');
    });
  }

  static Future<void> dbExistsFunc() async {
    if (dbExists == true) return;
    dbExists = File(dbFilePath).existsSync();
    print(dbExists);
    //db=await openDatabase('my_dbase.db');
  }
  // ////////////////////////////////////////////////////////////////////////////////

  static Future<void> tableExistsFunc() async {
    if (dbExists && db != null) {
      if (db!.isOpen) {
        var result = await db!
            .rawQuery('SELECT * FROM sqlite_master WHERE name="$tableName";');
        if (result.isEmpty) {
          tableExists = false;
          print('Table doesnt exist');
        } else {
          tableExists = true;
          print('table Exists');
        }
      } else {
        print('database doesnt exist');
      }
    }
  }

// ////////////////////////////////////////////////////////////////////////////////

  static void addDataToTable(List<SingleRecordClass> txRecords) async {
    int result;
    tableExistsFunc();
    if (dbExists && tableExists) {
      for (SingleRecordClass rec in txRecords) {
        result = await db!.rawInsert(
            'INSERT INTO data (Name, Age) VALUES ("${rec.name}", "${rec.age}")');
        print(result.toString());
      }
    }
  }
}
