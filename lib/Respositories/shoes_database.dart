import 'package:nieak_project/model/shoes_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ShoesDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Shoes.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE Shoes(idshoes TEXT PRIMARY KEY, nameshoes TEXT NOT NULL, price INTEGER NOT NULL, color TEXT NOT NULL, minsize INTEGER NOT NULL, maxsize INTEGER NOT NULL, brand TEXT NOT NULL, imagenumber INTEGER NOT NULL, status INTEGER NOT NULL);");
    }, version: _version);
  }

  static Future<int> addShoes(Shoes shoes) async {
    final db = await _getDB();
    return await db.insert("Shoes", shoes.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateShoes(Shoes shoes) async {
    final db = await _getDB();
    return await db.update("Shoes", shoes.toJson(),
        where: 'idshoes = ?',
        whereArgs: [shoes.idshoes],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteShoes(Shoes shoes) async {
    final db = await _getDB();
    return await db
        .delete("Shoes", where: 'idshoes = ?', whereArgs: [shoes.idshoes]);
  }

  static Future<List<Shoes>?> getAllShoes(String brand) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = brand == 'All'
        ? await db.query("Shoes")
        : await db.query("Shoes", where: 'brand = ?', whereArgs: [brand]);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Shoes.fromJson(maps[index]));
  }

  static Future<List<Shoes>?> findShoes(String name) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db
        .query("Shoes", where: 'nameshoes LIKE ?', whereArgs: ['%$name%']);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Shoes.fromJson(maps[index]));
  }
}
