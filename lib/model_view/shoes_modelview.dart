import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nieak_project/Respositories/shoes_database.dart';
import 'package:nieak_project/model/shoes_model.dart';

class ShoesModelView extends GetxController {
  var allShoes = <Shoes>[].obs;
  var result = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchAll("All");
  }

  fetchAll(String brand) async {
    var shoes = await ShoesDatabaseHelper.getAllShoes(brand);
    allShoes.value = shoes!;
  }

  addShoes(Shoes value) {
    ShoesDatabaseHelper.addShoes(value);
    fetchAll("All");
  }

  findShoes(String name, BuildContext context) async {
    var shoes = await ShoesDatabaseHelper.findShoes(name);
    if (shoes == null) {
      result.value = 1;
      allShoes.value = [];
    } else {
      allShoes.value = shoes;
    }
  }
}
