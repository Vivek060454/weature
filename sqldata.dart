import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class SQLHelper {




  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE iteme(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        temp TEXT,
        feelsLike TEXT,
        landmark TEXT,
        tempMin TEXT,
        tempMax TEXT,
         pressure TEXT,
        humidity TEXT,
        seaLevel TEXT,
         grndLevel TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbtecuh.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String temp, String? feelsLike,String landmark,String tempMin,String tempMax,
      String pressure, String? humidity,String seaLevel,String grndLevel,) async {
    final db = await SQLHelper.db();

    final data = {'temp': temp, 'feelsLike': feelsLike,'landmark':landmark,'tempMin':tempMin,'tempMax':tempMax,
      'pressure': pressure, 'humidity': humidity,'seaLevel':seaLevel,'grndLevel':grndLevel,  };
    final id = await db.insert('iteme', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('iteme', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('iteme', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("iteme", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}