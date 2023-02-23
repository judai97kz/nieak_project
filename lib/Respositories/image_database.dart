import 'dart:io';
import 'dart:typed_data';
import 'package:nieak_project/model/image_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Convert an image to a byte array
class ImageConvert {
  static Future<Uint8List> imageToByte(File image) async {
    final bytes = await image.readAsBytes();
    return Uint8List.fromList(bytes);
  }
  static Future<Database> getDB() async {
      return openDatabase(
        join(await getDatabasesPath(), 'images.db'),
        onCreate: (db, version) {
          // Create the table to store the image data
          return db.execute(
            'CREATE TABLE images(id TEXT PRIMARY KEY, groupimage TEXT, data BLOB)',
          );
        },
        version: 1,
      );

  }


 static Future<List<ImageModel>?> getImage() async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps =
    await db.query("images");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => ImageModel.fromJson(maps[index]));
  }

  static Future<List<ImageModel>?> getImageGroup(String group) async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps =
    await db.query("images",where: "groupimage = ?",whereArgs: [group]);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => ImageModel.fromJson(maps[index]));
  }

// Save an image to the database
  static Future<int> saveImage(ImageModel model) async {
    final db = await getDB();
    return await db.insert("images", model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteImage(String id) async {
    final db = await getDB();
    return await db
        .delete("images", where: 'id = ?', whereArgs: [id]);
  }
}
