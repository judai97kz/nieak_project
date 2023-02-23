import 'package:nieak_project/model/brand_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BrandDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Brand.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute("CREATE TABLE Brand(id TEXT PRIMARY KEY NOT NULL);");
    }, version: _version);
  }

  static Future<int> addBrand(BrandModel brand) async {
    final db = await _getDB();
    return await db.insert("Brand", brand.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateBrand(BrandModel brand) async {
    final db = await _getDB();
    return await db.update("Brand", brand.toJson(),
        where: 'id = ?',
        whereArgs: [brand.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteBrand(BrandModel brand) async {
    final db = await _getDB();
    return await db
        .delete("Brand", where: 'id = ?', whereArgs: [brand.id]);
  }

  static Future<List<BrandModel>?> getAllBrand() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Brand");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => BrandModel.fromJson(maps[index]));
  }

  static Future<List<BrandModel>?> findBrand(String name) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps =
        await db.query("Brand", where: 'id LIKE ?', whereArgs: ['%$name%']);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => BrandModel.fromJson(maps[index]));
  }
}
