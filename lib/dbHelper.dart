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
    print(' i will run table exist func');
    await tableExistsFunc();
  }

  static void dbExistsFunc() {
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
        print('\n here are the result=\n$result\n');
        if (result.isEmpty) {
          tableExists = false;
          print('Table doesnt exist');
        } else {
          tableExists = true;
          print('table Exists\n $result');
        }
      } else {
        print('database doesnt exist');
      }
    }
  }

// ////////////////////////////////////////////////////////////////////////////////

  static Future<void> addDataToTable(List<SingleRecordClass> txRecords) async {
    int result;
    if(txRecords.isEmpty){
      print('Empty table');
      return;
    }
    await tableExistsFunc();
    if (dbExists && tableExists) {
      for (SingleRecordClass rec in txRecords) {
        result = await db!.rawInsert(
            'INSERT INTO data (Name, Age) VALUES ("${rec.name}", "${rec.age}")');
        print(result.toString());
      }
    }
  }
/////////

  static void deleteDataInTable() {
    tableExistsFunc();
    if (dbExists && tableExists) {
      db!.delete('data');
      print('all data in data table were deleted');
    }
  }

  static Future<void> deleteTable() async {
    dbExistsFunc();
    tableExistsFunc();
    if (dbExists && tableExists) {
      await db!.execute('DROP TABLE IF EXISTS data');
      tableExists = false;
      print('table data deleted ');
    }
  }

  static Future<void> deleteDatabase() async {
    if (dbExists) {
      //await mydbHelper.db.execute('DROP TABLE IF EXISTS data');
      await db!.close();
      if (db!.isOpen == false) {
        var file = File(dbFilePath);
        if (file.existsSync() == true) {
          var ret = await file.delete();
          print(ret.exists());
          dbExists = false;
          tableExists = false;
          //await deleteDatabaseOriginal(databasesPath);
          print('database was deleted ');
        } else {
          print('file doesnt exist');
        }
      }
    }
  }

  static Future<void> deleteDatabaseOriginal(String path) async {
    return await databaseFactory.deleteDatabase(path).then((value) {
      dbExists = false;
      tableExists = false;
      return value;
    });
  }

  static Future<void> createTable() async {
    dbExistsFunc();
    await tableExistsFunc();

    if (dbExists == false) {
      print('db  doesnt exist');
      return;
    }

    if (dbExists == true && tableExists == false) {
      print('welcome to table will be created');
      await db!
          .execute('CREATE TABLE data '
              '(id INTEGER PRIMARY KEY AUTOINCREMENT,'
              ' name TEXT,'
              'age INTEGER'
              ')')
          .catchError((e) {
        print(e.toString());
      });
      tableExists = true;
      print('table created');
    } else {
      print('data table already exists');
    }
  }

  // static Future<void> addDatatoTable(List<SingleRecordClass> txRecords) async {
  //   var result;
  //   await tableExistsFunc();
  //   if (db!.isOpen && tableExists) {
  //     txRecords.forEach((element) async {
  //       result = await db!.rawInsert(
  //           'INSERT INTO data (Name, Age) VALUES ("${element.name}", "${element.age}")');
  //       print(result.toString());
  //     });
  //   }
  // }

  static Future<void> readFromDatabase() async {
    dbExistsFunc();
    //tableExistsFunc();
    if (dbExists) {
      if (db!.isOpen) {
        await tableExistsFunc();
        if (tableExists) {
          RecordsListClass.recordsList.clear();

          List<Map<String, dynamic>> showRecords = await db!.query('data');
          for (var element in showRecords) {
            RecordsListClass.recordsList.add(SingleRecordClass(
                element.values.elementAt(1), element.values.elementAt(2)));
            // print(element.values);
            // print(element.runtimeType);
            print(element.toString());
          }
        } else {
          print('table not found');
        }
      } else {
        print('database not opened yet');
      }
    } else
      print('database doesnt exist');
  }
}
