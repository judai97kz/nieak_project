import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/cart_database.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user_model.dart';
import '../screen/home_page.dart';

class UserDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Users.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE User(username TEXT PRIMARY KEY, password TEXT NOT NULL, name TEXT NOT NULL, phone TEXT NOT NULL, address TEXT NOT NULL, idcart TEXT NOT NULL);");
    }, version: _version);
  }

  static Future<int> addUser(User user) async {
    final db = await _getDB();
    return await db.insert("User", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(User user) async {
    final db = await _getDB();
    return await db.update("User", user.toJson(),
        where: 'username = ?',
        whereArgs: [user.username],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteUser(User user) async {
    final db = await _getDB();
    return await db
        .delete("User", where: 'username = ?', whereArgs: [user.username]);
  }

  static Future<void> getAllUser(
      String username, String password, BuildContext context) async {
    final getIdCart = Get.put(Userid());
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("User");

    if (maps.isEmpty) {
      return;
    }

    List<User> users = maps.map((a) => User.fromJson(a)).toList();
    for (int i = 0; i < users.length; i++) {
      if (users[i].username == username && users[i].password == password) {
        getIdCart.updateID(username);
        CartDatabase.getDB(username);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(keycart: 'id${username}')));
      }
    }
  }
}