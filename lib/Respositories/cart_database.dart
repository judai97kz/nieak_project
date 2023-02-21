import 'package:get/get.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/model/cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {
  static final idcartkey = Get.put(Userid());
  static const int _version = 1;

  static Future<Database> getDB(var dbName) async {
    return openDatabase(join(await getDatabasesPath(), "$dbName.db"),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE ${idcartkey.user.value!.idcart}(idproduct TEXT PRIMARY KEY, nameproduct TEXT NOT NULL, priceproduct INTEGER NOT NULL, amoutproduct INTEGER NOT NULL, sizeproduct INTEGER NOT NULL, brand TEXT NOT NULL);");
    }, version: _version);
  }

  static Future<int> addCart(CartModel shoes) async {
    final String dbName = idcartkey.user.value!.username;
    final db = await getDB(dbName);
    return await db.insert(idcartkey.user.value!.idcart, shoes.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateCart(CartModel shoes) async {
    final String dbName = idcartkey.user.value!.username;
    final db = await getDB(dbName);
    return await db.update(idcartkey.user.value!.idcart, shoes.toJson(),
        where: 'idproduct = ?',
        whereArgs: [shoes.idproduct],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteCart(CartModel shoes) async {
    final String dbName = idcartkey.user.value!.username;
    final db = await getDB(dbName);
    return await db.delete(idcartkey.user.value!.idcart,
        where: 'idproduct = ?', whereArgs: [shoes.idproduct]);
  }

  static Future<List<CartModel>?> getCart() async {
    final String dbName = idcartkey.user.value!.username;
    final db = await getDB(dbName);
    final List<Map<String, dynamic>> maps =
        await db.query(idcartkey.user.value!.idcart);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => CartModel.fromJson(maps[index]));
  }
}
