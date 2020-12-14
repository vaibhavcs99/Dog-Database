import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Dog.dart';
import 'First.dart';

class DBhelper {
  Future<Database> database;
  DBhelper() {
    initalizeDatabase();
  }
  void initalizeDatabase() async {
    database = openDatabase(join(await getDatabasesPath(), 'doggie.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)');
    }, version: 1);
  }

//todo try without void type safety

  Future<void> insertDog(Dog dog) async {
    final Database db = await database;

    await db.insert('dogs', dog.toMap());

    // await db.rawInsert('INSERT INTO dogs(name,age) VALUES (${dog.name} , ${dog.age})');
  }

  Future<List<Dog>> retrieveDogs() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    List<Dog> list = List.generate(
        maps.length,
        (i) => Dog(
              maps[i]['id'].toString() + " " + maps[i]['name'],
              maps[i]['age'],
            ));

    return list;
  }

  Future<void> deleteDogs(int newId) async {
    final Database db = await database;
    await db.delete('dogs', where: "id=?", whereArgs: [newId]);
  }

  Future<void> updateDogs(Dog dog) async {
    final Database db = await database;

    await db.update('dogs', dog.toMap(), where: 'id=?', whereArgs: [dog.id]);
  }
}
