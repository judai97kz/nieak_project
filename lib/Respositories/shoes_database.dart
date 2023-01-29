import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nieak_project/model/shoes_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ShoesDatabaseHelper{
  static const int _version=1;
  static const String _dbName = "Shoes.db";

  static Future<Database> _getDB() async{
    return openDatabase(join(await getDatabasesPath(),_dbName),
        onCreate: (db,version)async{
          await db.execute(
              "CREATE TABLE Shoe(idshoes TEXT PRIMARY KEY, nameshoes TEXT NOT NULL, price TEXT NOT NULL, color TEXT NOT NULL, minsize INTEGER NOT NULL, maxsize INTEGER NOT NULL, brand TEXT NOT NULL, imagenumber INTEGER NOT NULL);");
        },version: _version
    );
  }

  static Future<int> addShoes(Shoes shoes) async{
    final db = await _getDB();
    return await db.insert("Shoe", shoes.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static  Future<int> updateShoes(Shoes shoes) async {
    final db = await _getDB();
    return await db.update("Shoe", shoes.toJson(),where: 'idshoes = ?',whereArgs: [shoes.idshoes],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static  Future<int> deleteShoes(Shoes shoes) async {
    final db = await _getDB();
    return await db.delete("Shoe",where: 'idshoes = ?',whereArgs: [shoes.idshoes]);
  }

  static Future<List<Shoes>?> getAllShoes(String brand) async{
    final db = await _getDB();
    final List<Map<String,dynamic>> maps = brand=='All'?
      await db.query("Shoe"):await db.query("Shoe",where: 'brand = ?',whereArgs: [brand]);
    if(maps.isEmpty){
      return null;
    }
    return List.generate(maps.length, (index) => Shoes.fromJson(maps[index]));
  }

}