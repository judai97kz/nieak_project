import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nieak_project/model/shoes_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/image_model.dart';
import '../model_view/add_new.dart';
import '../model_view/image_modelview.dart';
import '../model_view/shoes_modelview.dart';

class ShoesDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Shoes.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE Shoes(idshoes TEXT PRIMARY KEY, nameshoes TEXT NOT NULL, price INTEGER NOT NULL, color TEXT NOT NULL, minsize INTEGER NOT NULL, maxsize INTEGER NOT NULL, brand TEXT NOT NULL, imagenumber INTEGER NOT NULL, amout INTEGER NOT NULL);");
    }, version: _version);
  }

  static Future<int> addShoes(Shoes shoes) async {
    final db = await _getDB();
    return await db.insert("Shoes", shoes.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateShoes(Shoes shoes) async {
    final db = await _getDB();
    return await db.update("Shoes", shoes.toJson(),
        where: 'idshoes = ?',
        whereArgs: [shoes.idshoes],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteShoes(Shoes shoes) async {
    final db = await _getDB();
    return await db
        .delete("Shoes", where: 'idshoes = ?', whereArgs: [shoes.idshoes]);
  }

  static Future<List<Shoes>?> getAllShoes(String brand) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = brand == 'All'
        ? await db.query("Shoes")
        : await db.query("Shoes", where: 'brand = ?', whereArgs: [brand]);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Shoes.fromJson(maps[index]));
  }

  static Future<List<Shoes>?> findShoes(String name) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db
        .query("Shoes", where: 'nameshoes LIKE ?', whereArgs: ['%$name%']);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Shoes.fromJson(maps[index]));
  }

  static Future<void> checkShoes(
      Shoes model, List<XFile> imageFileList, BuildContext context) async {
    final imagemodel = Get.put(ImageModelView());
    final shoes = Get.put(ShoesModelView());

    Future<Uint8List> fileToUint8List(File file) async {
      List<int> bytes = await file.readAsBytes();
      return Uint8List.fromList(bytes);
    }

    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db
        .query("Shoes", where: 'idshoes = ?', whereArgs: [model.idshoes]);
    if (maps.isEmpty) {
      addShoes(model);
      for (int i = 0; i < imageFileList.length; i++) {
        File imageFile = File(imageFileList[i].path);
        Uint8List uint8List = await fileToUint8List(imageFile);
        ImageModel newimage = ImageModel(
            id: "${model.idshoes}-${i + 1}",
            groupimage: model.idshoes,
            data: uint8List);
        imagemodel.addimage(newimage);
        shoes.fetchAll('All');
      }
      final theindex = Get.put(AddNew());
      theindex.index.value = 0;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm Sản Phẩm Thành Công!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mã sản phẩm đã tồn tại')));
    }
  }

}
