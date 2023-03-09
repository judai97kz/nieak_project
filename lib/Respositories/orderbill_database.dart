import 'package:get/get.dart';
import 'package:nieak_project/model/bill_model.dart';
import 'package:nieak_project/model/orderbill_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model_view/key_cart_user.dart';

class OrderBillDatabase {

  static const int _version = 1;
  static Future<Database> getDB() async {
    return openDatabase(join(await getDatabasesPath(), "bill.id"),
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE bill(idbill TEXT PRIMARY KEY, billtime TEXT NOT NULL, contentbill TEXT NOT NULL, pricebill INTEGER NOT NULL, userorder TEXT NOT NULL);");
        }, version: _version);
  }

  static Future<int> addBill(OrderBillModel bill) async {
    final db = await getDB();
    return await db.insert("bill", bill.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateBill(OrderBillModel bill) async {
    final db = await getDB();
    return await db.update("bill", bill.toJson(),
        where: 'idbill = ?',
        whereArgs: [bill.idbill],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteBill(OrderBillModel bill) async {

    final db = await getDB();
    return await db
        .delete("bill", where: 'idbill = ?', whereArgs: [bill.idbill]);
  }

  static Future<List<OrderBillModel>?> getAllBill() async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query("bill");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => OrderBillModel.fromJson(maps[index]));
  }
}
