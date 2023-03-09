import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nieak_project/Respositories/shoes_database.dart';
import 'package:nieak_project/model/shoes_model.dart';

class ShoesModelView extends GetxController {
  var allShoes = <Shoes>[].obs;
  var ManageShoes = <Shoes>[].obs;
  var result = 0.obs;
  var checkid = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchAll("All");
  }

  fetchAll(String? brand) async {
    var shoes = await ShoesDatabaseHelper.getAllShoes(brand!);
    allShoes.value = shoes!;
    var manashoes = await ShoesDatabaseHelper.getAllShoes('All');
    ManageShoes.value = manashoes!;

  }

  addShoes(Shoes value) {
    ShoesDatabaseHelper.addShoes(value);
    fetchAll("All");
  }

  findShoes(String name, BuildContext context) async {
    var shoes = await ShoesDatabaseHelper.findShoes(name,context);
    if (shoes == null) {
      result.value = 1;
      allShoes.value = [];
    } else {
      allShoes.value = shoes;
    }
  }

  deleteShoes(Shoes model) async {
    await ShoesDatabaseHelper.deleteShoes(model);
    fetchAll("All");
  }

  updateShoes(Shoes model) async {
    await ShoesDatabaseHelper.updateShoes(model);
    fetchAll("All");
  }

 checkShoes(Shoes model,List<XFile> imageFileList,BuildContext context) async {
   await ShoesDatabaseHelper.checkShoes(model,imageFileList,context);
  }
}
