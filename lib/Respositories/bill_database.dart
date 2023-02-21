import 'package:get/get.dart';
import 'package:nieak_project/model/bill_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model_view/key_cart_user.dart';

class BillDatabase {
  static final idcartkey = Get.put(Userid());
  static const int _version = 1;
  static Future<Database> getDB(var dbName) async {
    return openDatabase(join(await getDatabasesPath(), "${dbName}bill.id"),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE bill(idbill TEXT PRIMARY KEY, billtime TEXT NOT NULL, contentbill TEXT NOT NULL, pricebill INTEGER NOT NULL);");
    }, version: _version);
  }

  static Future<int> addBill(BillModel bill) async {
    final String dbName = idcartkey.user.value!.username;
    final db = await getDB(dbName);
    return await db.insert("bill", bill.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateBill(BillModel bill) async {
    final String dbName = idcartkey.user.value!.username;
    final db = await getDB(dbName);
    return await db.update("bill", bill.toJson(),
        where: 'idbill = ?',
        whereArgs: [bill.idbill],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteBill(BillModel bill) async {
    final String dbName = idcartkey.user.value!.username;
    final db = await getDB(dbName);
    return await db
        .delete("bill", where: 'idbill = ?', whereArgs: [bill.idbill]);
  }

  static Future<List<BillModel>?> getAllBill() async {
    final String dbName = idcartkey.user.value!.username;
    final db = await getDB(dbName);
    final List<Map<String, dynamic>> maps = await db.query("bill");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => BillModel.fromJson(maps[index]));
  }
}
