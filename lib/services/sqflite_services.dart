

import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mc_crud_test/model/users_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; //used to join paths


class SqliteService {

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path,"users.db"); //create path to database

    return await openDatabase( //open the database or create a database if there isn't any
        path,
        version: 1,
        onCreate: (Database db,int version) async{
          await db.execute("""
          CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          FName varchar(50) NOT NULL UNIQUE,
          Lname varchar(50) NOT NULL UNIQUE,
          DateOfBirth varchar(50) NOT NULL UNIQUE,
          PhoneNumber varchar(50) NOT NULL,
          Email varchar(50) NOT NULL UNIQUE,
          BankAccountNumber varchar(50) NOT NULL,
          Region varchar(100) NOT NULL)"""
          );
        });

  }

  Future<dynamic> addItem(UsersModel item) async{ //returns number of items inserted as an integer
    final db = await init(); //open database
    return db.insert("users", item.toJson(), //toMap() function from MemoModel
      // conflictAlgorithm: ConflictAlgorithm.fail, //ignores conflicts due to duplicate entries
    ).then((value) {
      return 'Submit Successful';
      // ignore: argument_type_not_assignable_to_error_handler
    }).catchError((e){
      DatabaseException error = e;
      return error.toString().substring(18,98);
    });
  }

  Future<dynamic> fetchUsers() async{ //returns the memos as a list (array)

    final db = await init();
    final maps = await db.query("users"); //query all the rows in a table as an array of maps

    print(maps);

    return maps;
  }

  Future<dynamic> updateUsers(int id, UsersModel item) async{ // returns the number of rows updated

    final db = await init();

    return await db.update(
        "users",
        item.toJson(),
        where: "id = ?",
        whereArgs: [id]
    ).then((value) {
      return 'Edit Successful';
    }).catchError((e){
      DatabaseException error = e;
      return error.toString();
    });
  }

  Future<dynamic> deleteUsers(int id) async{ //returns number of items deleted
    final db = await init();

    return await db.delete(
        "users", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
    ).then((value) {
      return 'Delete Successful';
    }).catchError((e){
      DatabaseException error = e;
      return error.toString();
    });

  }


}