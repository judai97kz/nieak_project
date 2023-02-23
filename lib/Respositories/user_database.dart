import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/bill_database.dart';
import 'package:nieak_project/Respositories/cart_database.dart';
import 'package:nieak_project/model_view/User_ModelView.dart';
import 'package:nieak_project/model_view/key_cart_user.dart';
import 'package:nieak_project/screen/management_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class UserDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Users.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE User(username TEXT PRIMARY KEY, password TEXT NOT NULL, name TEXT NOT NULL, phone TEXT NOT NULL, address TEXT NOT NULL, idcart TEXT NOT NULL, wallet INTEGER NOT NULL, role INTEGER NOT NULL);");
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

  static Future<bool> findUser(String username) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps =
        await db.query("User", where: 'username = ?', whereArgs: [username]);
    if (maps.isEmpty) {
      return false;
    }
    List<User> user = maps.map((a) => User.fromJson(a)).toList();

    for (int i = 0; i < user.length; i++) {
      if (user[i].username == username) {
        return true;
      }
    }
    return false;
  }

  static Future<List<User>?> getListUser() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("User");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => User.fromJson(maps[index]));
  }

  static Future<void> getAllUser(
      String username, String password, BuildContext context) async {
    final getIdCart = Get.put(Userid());
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("User");
    final user = Get.put(UserModelView());
    if (maps.isEmpty) {
      return;
    }
    int check = 0;
    List<User> users = maps.map((a) => User.fromJson(a)).toList();
    for (int i = 0; i < users.length; i++) {
      if (users[i].username == username && users[i].password == password) {
        User updateuser = User(
            username: users[i].username,
            password: users[i].password,
            name: users[i].name,
            phone: users[i].phone,
            address: users[i].address,
            idcart: users[i].idcart,
            wallet: users[i].wallet,
            role: users[i].role);
        getIdCart.updateID(updateuser);
        CartDatabase.getDB(username);
        BillDatabase.getDB(username);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);
        await prefs.setString('password', password);
        check = 0;
        if (users[i].role == 1) {
          user.getUser();
        }
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Managementpage()));
        break;
      }
      check++;
    }

    if (check > 0) {
      AlertDialog alert = AlertDialog(
        title: const Text("Thông báo"),
        content: const Text("Tên Đăng Nhập Và Mật Khẩu Không Chính Xác!"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Thoát"))
        ],
      );
      // ignore: use_build_context_synchronously
      showDialog(context: context, builder: (context) => alert);
      check = 0;
    }
  }
}
