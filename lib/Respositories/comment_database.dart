import 'package:get/get.dart';
import 'package:nieak_project/model/shoes_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/comment_model.dart';
import '../model_view/comment_modelview.dart';
import '../model_view/shoes_modelview.dart';

class CommentDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Comment.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
          await db.execute("CREATE TABLE Comment(idcomment TEXT PRIMARY KEY NOT NULL, usercomment TEXT NOT NULL, contentcomment TEXT NOT NULL, productcomment TEXT NOT NULL, starsrating REAL NOT NULL, datecomment TEXT NOT NULL);");
        }, version: _version);
  }

  static Future<int> addComment(CommentModel model) async {
    final db = await _getDB();
    return await db.insert("Comment", model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateComment(CommentModel Comment) async {
    final db = await _getDB();
    return await db.update("Comment", Comment.toJson(),
        where: 'idcomment = ?',
        whereArgs: [Comment.idcomment],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteComment(CommentModel Comment) async {
    final db = await _getDB();
    return await db
        .delete("Comment", where: 'idcomment = ?', whereArgs: [Comment.idcomment]);
  }

  static Future<List<CommentModel>?> getAllComment(String product) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Comment",where: 'productcomment = ?',whereArgs: [product]);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => CommentModel.fromJson(maps[index]));
  }

  static Future<void> countStars(Shoes Pro) async {
    final getComment = Get.put(CommentModelView());
    final shoes = Get.put(ShoesModelView());
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Comment",where: 'productcomment = ?',whereArgs: [Pro.idshoes]);
    if (maps.isEmpty) {
      return null;
    }
    double temp = 0;
    List<CommentModel> comments = maps.map((a) => CommentModel.fromJson(a)).toList();
    for(int i=0;i<comments.length;i++){
      temp += comments[i].starsrating;
    }
    temp = temp / comments.length;
    Shoes upshoes = Shoes(
        idshoes: Pro.idshoes,
        nameshoes: Pro.nameshoes,
        price: Pro.price,
        color: Pro.color,
        minsize: Pro.minsize,
        maxsize: Pro.maxsize,
        brand: Pro.brand,
        imagenumber: Pro.imagenumber,
        amout: Pro.amout,
        rating: temp);
    shoes.updateShoes(upshoes);
    getComment.substars.value = temp;
  }

  static Future<List<CommentModel>?> findComment(String name) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps =
    await db.query("Comment", where: 'idcomment LIKE ?', whereArgs: ['%$name%']);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => CommentModel.fromJson(maps[index]));
  }
}
