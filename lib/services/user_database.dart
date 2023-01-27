
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user_model.dart';

class UserDatabaseHelper{
  static const int _version=1;
  static const String _dbName = "Users.db";

  static Future<Database> _getDB() async{
    return openDatabase(join(await getDatabasesPath(),_dbName),
        onCreate: (db,version)async{
          await db.execute(
              "CREATE TABLE User(username TEXT PRIMARY KEY, password TEXT NOT NULL, name TEXT NOT NULL, phone TEXT NOT NULL, address TEXT NOT NULL, idcart TEXT NOT NULL);");
        },version: _version
    );
  }

  static Future<int> addUser(User user) async{
    final db = await _getDB();
    return await db.insert("User", user.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static  Future<int> updateUser(User user) async {
    final db = await _getDB();
    return await db.update("User", user.toJson(),where: 'username = ?',whereArgs: [user.username],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static  Future<int> deleteUser(User user) async {
    final db = await _getDB();
    return await db.delete("User",where: 'username = ?',whereArgs: [user.username]);
  }

  static Future<List<User>?> getAllUser() async{
    final db = await _getDB();
    final List<Map<String,dynamic>> maps = await db.query("User");
    if(maps.isEmpty){
      return null;
    }
    return List.generate(maps.length, (index) => User.fromJson(maps[index]));
  }


}