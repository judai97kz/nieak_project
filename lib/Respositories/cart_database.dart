import 'package:get/get.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/model/cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {
  static final idcartkey = Get.put(Userid());
  static const int _version = 1;

  static Future<Database> getDB(var _dbName) async {
    print(_dbName);
    return openDatabase(join(await getDatabasesPath(), "id${_dbName}.id"),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE id${idcartkey.idcart.value}(idproduct TEXT PRIMARY KEY, nameproduct TEXT NOT NULL, priceproduct INTEGER NOT NULL, amoutproduct INTEGER NOT NULL, sizeproduct INTEGER NOT NULL, brand TEXT NOT NULL);");
    }, version: _version);
  }

  static Future<int> addShoes(CartModel shoes) async {
    final String dbName = idcartkey.idcart.value;
    final db = await getDB(dbName);
    return await db.insert("id${idcartkey.idcart.value}", shoes.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateShoes(CartModel shoes) async {
    final String dbName = idcartkey.idcart.value;
    final db = await getDB(dbName);
    return await db.update("id${idcartkey.idcart.value}", shoes.toJson(),
        where: 'idproduct = ?',
        whereArgs: [shoes.idproduct],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteShoes(CartModel shoes) async {
    final String dbName = idcartkey.idcart.value;
    final db = await getDB(dbName);
    return await db.delete("id${idcartkey.idcart.value}",
        where: 'idproduct = ?', whereArgs: [shoes.idproduct]);
  }

  static Future<List<CartModel>?> getAllShoes() async {
    final String dbName = idcartkey.idcart.value;
    final db = await getDB(dbName);
    final List<Map<String, dynamic>> maps =
        await db.query("id${idcartkey.idcart.value}");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => CartModel.fromJson(maps[index]));
  }
}
